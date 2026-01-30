//
//  LoginViewModel.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false

    func login(username: String, password: String) async {
        do {
            try await AuthService.shared.login(username: username, password: password)
            isLoggedIn = true
        } catch {
            isLoggedIn = false
        }
    }

    func silentAuth() {
        isLoggedIn = (try? AuthService.shared.silentLogin()) ?? false
        print("isLoggedIn", isLoggedIn)
    }
}
