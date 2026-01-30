//
//  LoginViewModel.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import Combine
import AuthenticationServices
import Network

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    private let monitor = NWPathMonitor()
    private let tokenKey = "oauth_access_token"

    init() {
        monitor.start(queue: DispatchQueue.global())
    }

    // MARK: - Login
    func login(username: String, password: String) async {
        let token = "nuvento_oauth_token_123"
        KeyChainHelper.save(token, key: tokenKey)
        isLoggedIn = true
    }

    // MARK: - Silent Authentication
    func silentAuth() {
        if monitor.currentPath.status != .satisfied {
            logout()
        } else if KeyChainHelper.load(key: tokenKey) != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }

    // MARK: - Logout
    func logout() {
        KeyChainHelper.delete(key: tokenKey)
        isLoggedIn = false
    }
}
