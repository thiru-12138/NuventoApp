//
//  AuthService.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation

final class AuthService {
    static let shared = AuthService()
    private let tokenKey = "access_token"

    func login(username: String, password: String) async throws {
        // Mock OAuth token call
        let token = "mock_oauth_token_123"
        KeyChainHelper.save(token, key: tokenKey)
    }

    func silentLogin() throws -> Bool {
        guard NetworkMonitor.shared.isReachable else {
            logout()
            return false
        }
        return KeyChainHelper.load(key: tokenKey) != nil
    }

    func logout() {
        KeyChainHelper.delete(key: tokenKey)
    }
}
