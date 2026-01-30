//
//  NetworkMonitor.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private(set) var isReachable = true

    init() {
        monitor.pathUpdateHandler = {
            self.isReachable = $0.status == .satisfied
        }
        monitor.start(queue: .global())
    }
}
