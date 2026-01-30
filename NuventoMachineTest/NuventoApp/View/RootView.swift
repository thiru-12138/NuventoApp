//
//  RootView.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 30/01/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var log: LoginViewModel

    var body: some View {
        Group {
            if log.isLoggedIn {
                NavigationStack {
                    HomeScreenView()
                }
            } else {
                LoginScreenView()
            }
        }
        .task { [weak log] in
            await log?.silentAuth()
        }
    }
}
