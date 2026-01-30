//
//  NuventoMachineTestApp.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import SwiftUI
import CoreData

@main
struct NuventoMachineTestApp: App {
    @StateObject private var vm = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.light)
                .environmentObject(vm)
        }
    }
}
