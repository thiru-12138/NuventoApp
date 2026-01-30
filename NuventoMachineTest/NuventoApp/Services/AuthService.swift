//
//  AuthService.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation

// MARK: - Authorization Service
final class AuthService {
    static let shared = AuthService()
    private let tokenKey = "oauth_access_token"

    // MARK: - Login
    func login(username: String, password: String) async throws {
        let token = "nuvento_oauth_token_123"
        KeyChainHelper.save(token, key: tokenKey)
    }

    // MARK: - Force Logout
    func silentLogin() throws -> Bool {
        guard NetworkMonitor.shared.isReachable else {
            logout()
            return false
        }
        return false //KeyChainHelper.load(key: tokenKey) != nil
    }

    // MARK: - Logout
    func logout() {
        KeyChainHelper.delete(key: tokenKey)
    }
}
