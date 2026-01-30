//
//  RootView.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 30/01/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authVM: LoginViewModel

    var body: some View {
        Group {
            if authVM.isLoggedIn {
                NavigationStack {
                    HomeScreenView()
                }
            } else {
                LoginScreenView()
            }
        }
        .onAppear(perform: {
            authVM.silentAuth()
        })
    }
}
