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
                    NavigationLink(destination: DetailScreenView(devicename: device.name)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(device.name)
                                    .font(.headline)
                                Text(device.ipAddress)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Circle()
                                .fill(device.isReachable ? Color.green : Color.red)
                                .frame(width: 10, height: 10)
                            Text(device.isReachable ? "Reachable" : "Un-Reachable")
                                .foregroundColor(device.isReachable ? .green : .red)
                                .nuventoTextStyle()
                        }
                    }
                }
            }
        }
        .navigationTitle("Home - Discovery")
        .onAppear(perform: {
            vm.startDiscovery()
            
            // MARK: - Auto Logout
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                await log.silentAuth()
            }
        })
    }
}

#Preview {
    HomeScreenView()
}
