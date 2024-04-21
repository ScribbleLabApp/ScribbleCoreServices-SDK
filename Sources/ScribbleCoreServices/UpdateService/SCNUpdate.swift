//
//  File.swift
//  
//
//  Created by Nevio Hirani on 20.04.24.
//

import Foundation
import SwiftUI

/// Represents a GitHub release containing information about the release tag, whether it's a pre-release, and the assets associated with the release.
@available(iOS 17.0, macOS 14.0, *)
public struct GitHubRelease: Decodable {
    /// The name of the release tag.
    let tagName: String
    
    /// Indicates whether the release is a pre-release.
    let preRelease: Bool
    
    /// An array of ```GitHubAsset``` objects associated with the release.
    let assets: [GitHubAsset]
}

/// Represents an asset associated with a GitHub release, containing information about the asset name and its download URL.
@available(iOS 17.0, macOS 14.0, *)
public struct GitHubAsset: Decodable {
    /// The name of the asset.
    let name: String
    
    /// The URL for downloading the asset.
    let downloadUrl: String
}

/// Errors that can occur during the update process.
///
/// This enum represents various errors that can occur while handling updates, including errors related to file operations, network communication, parsing data, and API responses.
@available(iOS 17.0, macOS 14.0, *)
public enum SCNUpdateError: Error {
    /// Indicates that the DMG file is invalid.
    case invalidDMGFile(code: Int)
    
    /// Indicates that mounting the DMG file failed.
    case mountingFailed(code: Int)
    
    /// Indicates that no mounted volume was found.
    case noMountedVolume(code: Int)
    
    /// Indicates that application installation failed.
    case applicationInstallationFailed(code: Int)
    
    /// Indicates that application removal failed.
    case applicationRemovalFailed(code: Int)
    
    /// Indicates that moving the application failed.
    case applicationMoveFailed(code: Int)
    
    /// Represents errors related to network operations.
    ///
    /// - Parameters:
    ///    - code: The error code associated with the network error.
    case networkError(code: Int)
    
    /// Represents errors related to parsing data.
    ///
    /// - Parameters:
    ///     - code: The error code associated with the parsing error.
    case parsingError(code: Int)
    
    /// Represents errors when no releases are found.
    ///
    /// - Parameters:
    ///     - code: The error code associated with the "no releases found" error.
    case noReleasesFound(code: Int)
    
    /// Represents errors when the user is not eligible.
    ///
    /// - Parameters:
    ///     - code: The error code associated with the "user not eligible" error.
    case userNotEligible(code: Int)
    
    /// Represents errors related to API responses.
    ///
    /// - Parameters:
    ///     - statusCode: The status code of the API response.
    ///     - code: The custom error code associated with the API error.
    ///     - message: Additional information about the API error.
    case apiError(statusCode: Int, code: Int, message: String?)
}

#if os(macOS)
/// A service for handling updates from GitHub releases.
///
/// This service allows fetching the latest releases from a GitHub repository, downloading release assets, and performing necessary actions for updating the application.
///
/// - Note: This service is designed for macOS.
///
/// ## Example
///
/// ```swift
/// SCNUpdateService.shared.downloadReleaseAsset(subscribedChannel: "stable") { result in
///     switch result {
///     case .success:
///         print("Update downloaded and installed successfully!")
///     case .failure(let error):
///         print("Failed to download and install update: \(error)")
///     }
/// }
/// ```
@available(macOS 14.0, *)
public struct SCNUpdateService {
    
    static let shared = SCNUpdateService()
    
    /// The GitHub repository name in the format "<username>/<repository>".
    let repo = "ScribbleLabApp/ScribbleLab"
    
    /// The filename of the asset to be downloaded.
    let assetFileName = "ScribbleLab.dmg"
    
    /// Fetches the latest releases from GitHub.
    ///
    /// - Parameters:
    ///   - channel: The channel for which releases are to be fetched. Valid values are "stable" or "pre-release".
    ///   - completion: A closure to be called once the fetch operation is completed. It returns a result with an array of `GitHubRelease` on success or an `SCNGitHubError` on failure.
    func fetchReleases(channel: String, completion: @escaping (Result<[GitHubRelease], SCNUpdateError>) -> Void) {
        let url: URL
            if channel == "stable" {
                url = URL(string: "https://api.github.com/repos/\(repo)/releases/latest")!
            } else { // "pre"
                url = URL(string: "https://api.github.com/repos/\(repo)/releases/")!
            }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.networkError(code: -100)))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.networkError(code: -101)))
                return
            }
            
            if httpResponse.statusCode == 404 {
                completion(.failure(.noReleasesFound(code: -404)))
                return
            } else if httpResponse.statusCode == 403 {
                completion(.failure(.userNotEligible(code: -403)))
                return
            } else if !(200...299).contains(httpResponse.statusCode) {
                let errorMessage = String(data: data, encoding: .utf8)
                completion(.failure(.apiError(
                    statusCode: httpResponse.statusCode, 
                    code: httpResponse.statusCode,
                    message: errorMessage)
                ))
                return
            }
            
            do {
                let releases = try JSONDecoder().decode([GitHubRelease].self, from: data)
                let filteredReleases: [GitHubRelease]
                if channel.lowercased() == "stable" {
                    filteredReleases = releases.filter { !$0.preRelease }
                } else {
                    filteredReleases = releases.filter { $0.preRelease }
                }
                if filteredReleases.isEmpty {
                    completion(.failure(.noReleasesFound(code: -404)))
                } else {
                    completion(.success(filteredReleases))
                }
            } catch {
                completion(.failure(.parsingError(code: -102)))
            }
        }
        task.resume()
    }
    
    /// Downloads the release asset corresponding to the subscribed channel if a newer version is available.
    ///
    /// - Parameters:
    ///   - subscribedChannel: The channel for which the asset is to be downloaded. Valid values are "stable" or "pre-release".
    ///   - currentVersion: The current version of the application for comparison with the latest release version.
    ///   - completion: A closure to be called once the download operation is completed. It returns a `Result` with a `Void` value on success or an `Error` on failure.
    func downloadReleaseAsset(subscribedChannel: String, currentVersion: String, completion: @escaping (Result<Void, Error>) -> Void) {
        fetchReleases(channel: subscribedChannel) { result in
            switch result {
            case .success(let releases):
                if let latestRelease = releases.first {
                    let latestVersion = latestRelease.tagName
                    
                    // Compare the latest version with the current version
                    if latestVersion > currentVersion {
                        // Newer version available, proceed with downloading the asset
                        if let asset = latestRelease.assets.first(where: { $0.name == assetFileName }) {
                            self.downloadAsset(assetUrl: asset.downloadUrl, completion: completion)
                        } else {
                            completion(.failure(NSError(domain: "Asset not found", code: -1, userInfo: nil)))
                        }
                    } else {
                        // No newer version available
                        completion(.success(()))
                    }
                } else {
                    completion(.failure(NSError(domain: "No releases found", code: -1, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func downloadAsset(assetUrl: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: assetUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1000, userInfo: nil)))
            return
        }
        let task = URLSession.shared.downloadTask(with: url) { (tempLocalUrl, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: -1001, userInfo: nil)))
                return
            }
            guard let tempLocalUrl = tempLocalUrl else {
                completion(.failure(NSError(domain: "No data received", code: -1002, userInfo: nil)))
                return
            }
            do {
                let downloadsFolderUrl = try FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let destinationUrl = downloadsFolderUrl.appendingPathComponent(assetFileName)
                try FileManager.default.moveItem(at: tempLocalUrl, to: destinationUrl)
                try self.executeDMG(at: destinationUrl, completion: completion)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func executeDMG(at url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        let process = Process()
        process.launchPath = "/usr/bin/hdiutil"
        process.arguments = ["attach", url.path]
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        process.terminationHandler = { process in
            guard process.terminationStatus == 0 else {
                completion(.failure(SCNUpdateError.mountingFailed(code: Int(process.terminationStatus))))
                return
            }
            
            if let mountedVolumePath = self.getMountedVolumePath(for: url) {
                self.installApplication(fromDMG: url, mountedVolumePath: mountedVolumePath, completion: completion)
            } else {
                completion(.failure(SCNUpdateError.noMountedVolume(code: -2)))
            }
        }
        
        process.launch()
        process.waitUntilExit()
    }
    
    private func installApplication(fromDMG dmgURL: URL, mountedVolumePath: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        let applicationsURL = URL(fileURLWithPath: "/Applications")
        let appToInstallURL = applicationsURL.appendingPathComponent("ScribbleLab.app")
        let appInDMGURL = mountedVolumePath.appendingPathComponent("ScribbleLab.app")
        
        guard FileManager.default.fileExists(atPath: appInDMGURL.path) else {
            completion(.failure(SCNUpdateError.invalidDMGFile(code: -3)))
            return
        }
        
        if FileManager.default.fileExists(atPath: appToInstallURL.path) {
            do {
                try FileManager.default.removeItem(at: appToInstallURL)
            } catch {
                completion(.failure(SCNUpdateError.applicationRemovalFailed(code: -4)))
                return
            }
        }
        
        do {
            try FileManager.default.moveItem(at: appInDMGURL, to: appToInstallURL)
            self.detachDMG(at: dmgURL)
            completion(.success(()))
        } catch {
            completion(.failure(SCNUpdateError.applicationMoveFailed(code: -5)))
        }
    }
    
    private func getMountedVolumePath(for dmgURL: URL) -> URL? {
        let process = Process()
        process.launchPath = "/usr/sbin/diskutil"
        process.arguments = ["info", dmgURL.path]
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        
        guard let output = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        let lines = output.components(separatedBy: .newlines)
        for line in lines {
            if line.contains("Mount Point:") {
                let components = line.components(separatedBy: ":")
                if components.count > 1 {
                    let mountPoint = components[1].trimmingCharacters(in: .whitespaces)
                    return URL(fileURLWithPath: mountPoint)
                }
            }
        }
        
        return nil
    }
    
    private func detachDMG(at url: URL) {
        let process = Process()
        process.launchPath = "/usr/bin/hdiutil"
        process.arguments = ["detach", url.path]
        process.launch()
    }
}
#elseif os(iOS) || os(visionOS)
/// A service for handling updates from GitHub releases.
///
/// This service allows fetching the latest releases from a GitHub repository, performing necessary actions for updating the application and link to the latest App Store release.
///
/// - Note: This service is designed for iOS.
@available(iOS 17.0, visionOS 1.0, *)
public struct SCNUpdateService {
    static let shared = SCNUpdateService()
    
    /// The GitHub repository name in the format "`<username>/<repository>`".
    let repo = "ScribbleLabApp/ScribbleLab"
    
    /// A Boolean value indicating whether an update is available.
    ///
    /// This state variable is used to track whether there is a newer version of the application available for update.
    @State private var isUpdateAvailable: Bool = false
    
    /// Fetches the latest releases from GitHub.
    ///
    ///  - Parameters:
    ///     - channel: The channel for which releases are to be fetched. Valid values are "stable" or "pre-release".
    ///     - completion: A closure to be called once the fetch operation is completed. It returns a result with an array of `GitHubRelease` on success or an `SCNUpdateError` on failure.
    func fetchReleases(channel: String, completion: @escaping (Result<[GitHubRelease], SCNUpdateError>) -> Void) {
        let url: URL
        if channel == "stable" {
            url = URL(string: "https://api.github.com/repos/\(repo)/releases/latest")!
        } else {
            url = URL(string: "https://api.github.com/repos/\(repo)/releases/")!
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.networkError(code: -100)))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.networkError(code: -101)))
                return
            }
            
            if httpResponse.statusCode == 404 {
                completion(.failure(.noReleasesFound(code: -404)))
                return
            } else if httpResponse.statusCode == 403 {
                completion(.failure(.userNotEligible(code: -403)))
                return
            } else if !(200...299).contains(httpResponse.statusCode) {
                let errorMessage = String(data: data, encoding: .utf8)
                completion(.failure(.apiError(
                    statusCode: httpResponse.statusCode,
                    code: httpResponse.statusCode,
                    message: errorMessage)
                ))
                return
            }
            
            do {
                let releases = try JSONDecoder().decode([GitHubRelease].self, from: data)
                let filteredReleases: [GitHubRelease]
                if channel.lowercased() == "stable" {
                    filteredReleases = releases.filter { !$0.preRelease }
                } else {
                    filteredReleases = releases.filter { $0.preRelease }
                }
                if filteredReleases.isEmpty {
                    completion(.failure(.noReleasesFound(code: -404)))
                } else {
                    completion(.success(filteredReleases))
                }
            } catch {
                completion(.failure(.parsingError(code: -102)))
            }
        }
        task.resume()
    }
    
    /// Checks for updates based on the current version of the application.
    ///
    /// This function fetches the latest releases from GitHub and compares the latest version with the current version of the application.
    /// If a newer version is available, it sets the `isUpdateAvailable` flag to `true`.
    ///
    /// - Parameters:
    ///     - channel: The channel for which updates are to be checked. Valid values are "stable" or "pre-release".
    func checkForUpdate(channel: String) {
        fetchReleases(channel: channel) { result in
            switch result {
            case .success(let releases):
                if let latestRelease = releases.first {
                    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                    if latestRelease.tagName > currentVersion {
                        DispatchQueue.main.async {
                            self.isUpdateAvailable = true
                        }
                    }
                }
            case .failure(let error):
                print("Failed to fetch releases: \(error)")
            }
        }
    }
}

#endif
