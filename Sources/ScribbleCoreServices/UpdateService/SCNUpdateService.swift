/*
 See the LICENSE file for this Package licensing information.
 
 Abstract:
 ScribbleLabApp's official Updating Service
 
 Copyright (c) 2024 ScribbleLabApp.
 */

import Foundation
import SwiftUI

/// A service for handling updates from GitHub releases.
///
/// This service allows fetching the latest releases from a GitHub repository, performing necessary actions for updating the application and link to the latest App Store release.
///
/// > IMPORTANT:
/// > This service is currently in development stage and so not ready for production use yet. Usage on your own risk!
///
@available(iOS 17, macOS 14.0, *)
@MainActor public class SCNUpdateService: ObservableObject {
    
    static let shared = SCNUpdateService()
    
    /// The GitHub repository name in the format "`<username>/<repository>`".
    let repo = "ScribbleLabApp/ScribbleLab"
    
    private var latestRelease: GitHubRelease?
    
    /// A Boolean value indicating whether an update is available.
    ///
    /// This state variable is used to track whether there is a newer version of the application available for update
    @Published var isUpdateAvailable: Bool = false
    
    /// Fetches the latest releases from GitHub.
    ///
    /// - Parameters:
    ///   - channel: The channel for which releases are to be fetched. Valid values are "stable" or "pre-release".
    ///   - completion: A closure to be called once the fetch operation is completed. It returns a result with a `GitHubRelease` on success or an `SCNUpdateError` on failure.
    @available(iOS 17, macOS 14.0, *)
    public func fetchReleases(
        channel: SCNChannel,
        completion: @escaping (Result<GitHubRelease, SCNUpdateError>) -> Void
    ) {
        let url: URL
        
        if channel == SCNChannel.stable {
            url = URL(string: "https://api.github.com/repos/\(repo)/releases/latest")!
        } else if channel == SCNChannel.pre_release {
            url = URL(string: "https://api.github.com/repos/\(repo)/releases/")!
        } else {
            fatalError("SCN_ERR: Unknown Channel")
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.networkError(code: -100)))
                print("A network error occurred while fetching releases from API\n error code: -100")
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(.networkError(code: -101)))
                print("A network error occurred while fetching releases from API\n error code: -101")
                return
            }
            
            if httpResponse.statusCode == 404 {
                completion(.failure(.noReleasesFound(code: -404)))
                print("No releases found while fetching release history\n https err: 404 ・ scn err: -404")
                return
            } else if httpResponse.statusCode == 403 {
                completion(.failure(.userNotEligible(code: -403)))
                print("User not eligible to access releases from API\n https err: 403 ・ scn err: -403")
                return
            } else if !(200...299).contains(httpResponse.statusCode) {
                let errorMessage = String(data: data, encoding: .utf8)
                completion(.failure(.apiError(
                    statusCode: httpResponse.statusCode,
                    httpsStatusCode: httpResponse.statusCode,
                    message: errorMessage)
                ))
                return
            }
            
            do {
                let release = try JSONDecoder().decode(GitHubRelease.self, from: data)
                self.latestRelease = release
                completion(.success(release))
            } catch {
                completion(.failure(.parsingError(code: -102)))
            }
        }
        task.resume()
    }
    
    /// Checks for updates based on the current version of the application.
    ///
    /// This function fetches the latest releases from GitHub and compares the latest version with the current version of the application. If a newer version is available, it sets the `isUpdateAvailable` flag to `true`.
    ///
    /// - Parameters:
    ///     - channel: The channel for which updates are to be checked. Valid values are "stable" or "pre-release".
    ///
    @available(iOS 17, macOS 14.0, *)
    public func checkForUpdate(channel: SCNChannel) {
        fetchReleases(channel: channel) { result in
            switch result {
            case .success(let latestRelease):
                let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                if latestRelease.tagName > currentVersion {
                    DispatchQueue.main.async {
                        self.isUpdateAvailable = true
                    }
                }
            case .failure(let error):
                print("Failed to fetch releases: \(error)")
            }
        }
    }
    
    #if os(macOS)
    /// Downloads a release asset from GitHub for the subscribed channel.
    ///
    /// - Parameters:
    ///   - channel: The subscribed channel for which to download the asset.
    ///   - completion: A closure to be called once the download is completed. It returns the local URL of the downloaded asset on success, or an error on failure.
    @available(macOS 14.0, *)
    public func downloadReleaseAsset(
        channel: SCNChannel,
        completion: @escaping (Result<URL, Error>) -> Void
    ) {
        guard let latestRelease = self.latestRelease else {
            completion(.failure(SCNUpdateError.noReleasesFound(code: -404)))
            return
        }
        
        // Check if the latest release has assets
        guard !latestRelease.assets.isEmpty else {
            completion(.failure(SCNUpdateError.noReleasesFound(code: -404)))
            print("SCN_ERR: No release assets found!\n scn err: -404")
            return
        }
        
        // Find the DMG asset
        guard let dmgAsset = latestRelease.assets.first(where: { $0.name.hasSuffix(".dmg") }) else {
            completion(.failure(SCNUpdateError.noReleasesFound(code: -404)))
            print("SCN_ERR: No dmg in release asset found!\n scn err: -404")
            return
        }
        
        // Create URL for the asset's download link
        guard let assetURL = URL(string: dmgAsset.downloadURL) else {
            completion(.failure(SCNUpdateError.apiError(statusCode: -1, httpsStatusCode: -1, message: "Invalid asset download URL")))
            return
        }
        
        // Create destination URL for downloading the asset to the Downloads folder
        let destinationURL = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Downloads")
            .appendingPathComponent(dmgAsset.name)
        
        // Create download task
        let downloadTask = URLSession.shared.downloadTask(with: assetURL) { (tempURL, response, error) in
            if let tempURL = tempURL {
                do {
                    // Move downloaded file to the destination URL
                    try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                    completion(.success(destinationURL))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(SCNUpdateError.networkError(code: -1)))
            }
        }
        
        downloadTask.resume()
    }
    #endif
    
    // TODO: - installer: mount/un-mount, move and reopen application, clean up installation
}

@available(iOS 17, macOS 14.0, *)
extension SCNUpdateService {
    /// Subscribes to the specified channel and stores the selection in UserDefaults.
    ///
    /// - Parameters:
    ///     - channel: The channel to subscribe to.
    public func subscribeToChannel(channel: String) {
        guard let scnChannel = SCNChannel(rawValue: channel) else {
            fatalError("SCN_ERR: Invalid channel")
        }
        
        /// Use the setAsSubscribed method to store the channel in UserDefaults
        scnChannel.setAsSubscribed()
    }
}
