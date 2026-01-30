//
//  DetailScreenView.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import SwiftUI

struct DetailScreenView: View {
    let devicename: String
    @StateObject private var vm: DetailViewModel
    
    init(devicename: String) {
        self.devicename = devicename
        
        let service = APIService()
        _vm = StateObject(wrappedValue: DetailViewModel(service: service))
    }

    var body: some View {
        ZStack {
            VStack {
                if vm.isLoading {
                    ProgressView("Getting Details")
                } else if let errorMessage = vm.errorMessage {
                    Text(errorMessage).nuventoTextStyle().padding()
                } else {
                    if let info = vm.info {
                        Form {
                            Section("Device Name") {
                                Text("\(devicename)")
                            }
                            Section("IP Address") {
                                Text(info.ip)
                            }
                            Section("Location") {
                                Text("\(info.city), \(info.region)")
                                Text(info.country)
                            }
                            Section("Provider") {
                                Text(info.org)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Device Details")
        .task { [weak vm] in
            await vm?.load()
        }
    }
}
