//
//  DNSService.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import Network
import Combine

// MARK: - DNS Service
class DNSService: NSObject, ObservableObject, NetServiceBrowserDelegate, NetServiceDelegate {
    private var browser = NetServiceBrowser()
    private var services = Set<NetService>()
    @Published var devices: [DeviceEntity] = []
    var onDeviceFound: ((DeviceModel) -> Void)?
    
    override init() {
        super.init()
        browser.delegate = self
    }

    // MARK: - Search Devices
    func startDiscovery() {
        devices.forEach { $0.isReachable = false }
        browser.searchForServices(ofType: "_airplay._tcp.", inDomain: "local.")
    }

    // MARK: - NetServiceBrowserDelegate
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        services.insert(service)
        service.delegate = self
        service.resolve(withTimeout: 5.0)
    }

    // MARK: - Getting Device Data
    func netServiceDidResolveAddress(_ sender: NetService) {
        if let data = sender.addresses?.first {
            let ipAddress = getIPAddress(from: data) ?? "Unknown"
            let device = DeviceModel(
                name: sender.name,
                ipAddress: ipAddress,
                isReachable: true
            )
            onDeviceFound?(device)
        }
    }

    // MARK: - Get Device IPAddress
    private func getIPAddress(from data: Data) -> String? {
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        data.withUnsafeBytes { ptr in
            let sockaddrPtr = ptr.baseAddress?.assumingMemoryBound(to: sockaddr.self)
            getnameinfo(sockaddrPtr, socklen_t(data.count), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST)
        }
        return String(cString: hostname)
    }
}
