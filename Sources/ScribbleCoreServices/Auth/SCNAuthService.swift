/*
See the LICENSE file for this Package licensing information.

Abstract:
SCNAuthService Protocol for ScribbleLabApp's AuthService
 
Copyright (c) 2024 ScribbleLabApp.
*/

import Foundation

/// A protocol defining authentication-related operations.
@available(iOS 17.0, *)
public protocol SCNAuthService {
    
    /// Logs in the user with the provided email and password asynchronously.
    /// - Parameters:
    ///   - email: The email of the user.
    ///   - password: The password of the user.
    /// - Throws: An error if the login operation fails.
    func logIn(withEmail email: String, password: String) async throws
    
    /// Creates a new user with the provided email, password, and username asynchronously.
    /// - Parameters:
    ///   - email: The email of the user to be created.
    ///   - password: The password for the new user.
    ///   - username: The username for the new user.
    /// - Throws: An error if the user creation operation fails.
    func createUser(email: String, password: String, username: String) async throws
    
    /// Loads user data asynchronously.
    /// - Throws: An error if the user data cannot be loaded.
    func loadUserData() async throws
    
    /// Signs out the current user.
    func signOut()
    
    /// Resets the password for the specified email asynchronously.
    /// - Parameters:
    ///   - email: The email for which the password will be reset.
    ///   - resetCompletion: A closure that is called upon completion of the password reset operation.
    static func resetPassword(email: String, resetCompletion: @escaping (Result<Bool, Error>) -> Void)
}
