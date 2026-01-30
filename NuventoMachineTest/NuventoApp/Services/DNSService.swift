//
//  DNSService.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import Network

final class DNSService: NSObject, NetServiceBrowserDelegate, NetServiceDelegate {
    private let browser = NetServiceBrowser()
    var onDeviceFound: ((DeviceModel) -> Void)?

    func start() {
        browser.delegate = self
        browser.searchForServices(ofType: "_airplay._tcp.", inDomain: "")
    }

    func netServiceBrowser(_ browser: NetServiceBrowser,
                           didFind service: NetService,
                           moreComing: Bool) {
        service.delegate = self
        service.resolve(withTimeout: 5)
    }

    func netServiceDidResolveAddress(_ sender: NetService) {
        let ip = sender.hostName ?? "Unknown"
        let device = DeviceModel(
            name: sender.name,
            ipAddress: ip,
            isReachable: true
        )
        onDeviceFound?(device)
    }
}
