//
//  HomeScreenView.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var log: LoginViewModel
    @StateObject private var vm = HomeViewModel()

    var body: some View {
        ZStack {
            if vm.devices.count == 0 {
                Text("No Devices Found").nuventoTextStyle()
            } else {
                List(vm.devices) { device in
                    NavigationLink(destination: DetailScreenView(device: device)) {
                        VStack(alignment: .leading) {
                            Text(device.name)
                                .nuventoTextStyle()
                            Text(device.ipAddress)
                                .nuventoTextStyle()
                            Text(device.isReachable ? "Reachable" : "Un-Reachable")
                                .foregroundColor(device.isReachable ? .green : .red)
                                .nuventoTextStyle()
                        }
                    }
                }
            }
        }
        .navigationTitle("Home")
        .onAppear(perform: {
            vm.startDiscovery()
            
            // MARK: - Auto Logout
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                log.silentAuth()
            }
        })
    }
}

#Preview {
    HomeScreenView()
}
