//
//  File.swift
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

import Foundation

/// A protocol for fetching user-related data asynchronously.
///
/// Use the `SCNUserService` protocol to define a service that fetches user data from a remote source asynchronously.
///
/// This protocol provides methods for fetching a single user by UID and fetching all users available.
///
/// ### Example Usage:
/// ```swift
/// struct RemoteUserService: SCNUserService {
///    // Implementation of SCNUserService methods
/// }
/// ```
///
/// - Requires: iOS 17.0 or later.
/// - Tag: SCNUserService
@available(iOS 17.0, *)
protocol SCNUserService {
    
    /// The type representing a user. Must conform to `Identifiable`, `Hashable`, and `Codable`.
    associatedtype UserType: Identifiable & Hashable & Codable
    
    /// Fetches a user with the specified UID asynchronously.
    ///
    /// - Parameters:
    ///    - uid: The unique identifier of the user to fetch.
    ///
    /// - Returns: A `UserType` representing the fetched user.
    ///
    /// - Throws: An error if the user fetching operation fails.
    func fetchUser(withUid uid: String) async throws -> UserType
    
    /// Fetches all users available asynchronously.
    ///
    /// - Returns: An array of `UserType` representing all available users.
    ///
    /// - Throws: An error if the operation of fetching all users fails.
    func fetchAllUsers() async throws -> [UserType]
}
