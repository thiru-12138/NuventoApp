//
//  ObjectModel.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation

// MARK: - IP Model
struct IPResponse: Codable {
    let ip: String
}

struct IPInfo: Codable {
    let ip: String
    let city: String
    let region: String
    let country: String
    let org: String
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case ip, city, region, country, org, timezone
    }
}

// MARK: - Device Model
struct DeviceModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let ipAddress: String
    let isReachable: Bool
    
    init(id: UUID = UUID(), name: String, ipAddress: String, isReachable: Bool) {
        self.id = id
        self.name = name
        self.ipAddress = ipAddress
        self.isReachable = isReachable
    }
}
