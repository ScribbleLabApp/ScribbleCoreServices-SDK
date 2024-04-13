//
//  File.swift
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

import Foundation

@available(iOS 17.0, *)
protocol SCNAuthService {
    func logIn(withEmail email: String, password: String) async throws
    func createUser(email: String, password: String, username: String) async throws
    func loadUserData() async throws
    func signOut()
    static func resetPassword(email: String, resetCompletion: @escaping (Result<Bool, Error>) -> Void)
}
