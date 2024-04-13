//
//  File.swift
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

import Foundation

@available(iOS 17.0, *)
protocol SCNUserService {
    associatedtype UserType: Identifiable & Hashable & Codable
    func fetchUser(withUid uid: String) async throws -> UserType
    func fetchAllUsers() async throws -> [UserType]
}
