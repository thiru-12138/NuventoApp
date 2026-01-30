//
//  HomeScreenView.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import SwiftUI

struct HomeScreenView: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {
        ZStack {
            List(vm.devices) { device in
                NavigationLink(destination: DetailScreenView(device: device)) {
                    VStack(alignment: .leading) {
                        Text(device.name)
                        Text(device.ipAddress)
                        Text(device.isReachable ? "Reachable" : "Un-Reachable")
                            .foregroundColor(device.isReachable ? .green : .red)
                    }
                }
            }
        }
        .navigationTitle("Home")
        .onAppear(perform: {
            vm.startDiscovery()
        })
    }
}

#Preview {
    HomeScreenView()
}
