//
//  DetailScreenView.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import SwiftUI

struct DetailScreenView: View {
    let device: DeviceModel
    @StateObject private var vm: DetailViewModel
    
    init(device: DeviceModel) {
        self.device = device
        
        let service = APIService()
        _vm = StateObject(wrappedValue: DetailViewModel(service: service))
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Device: \(device.name)")
                if let info = vm.info {
                    Text("City: \(info.city ?? "-")")
                    Text("Region: \(info.region ?? "-")")
                    Text("Country: \(info.country ?? "-")")
                    Text("Company: \(info.org ?? "-")")
                }
            }.padding()
        }
        .navigationTitle("Details")
        .task { [weak vm] in
            await vm?.load()
        }
    }
}
