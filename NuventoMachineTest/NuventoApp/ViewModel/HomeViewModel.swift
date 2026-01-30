//
//  HomeViewModel.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var devices: [DeviceModel] = []
    private let mdns = DNSService()

    init() {
        mdns.onDeviceFound = { [weak self] device in
            self?.saveAndUpdate(device)
        }
    }

    func startDiscovery() {
        loadFromCoreData()
        mdns.start()
    }

    private func saveAndUpdate(_ device: DeviceModel) {
        CoreDataStack.shared.save(device)
        devices = CoreDataStack.shared.fetchDevices()
    }

    private func loadFromCoreData() {
        devices = CoreDataStack.shared.fetchDevices()
    }
}
