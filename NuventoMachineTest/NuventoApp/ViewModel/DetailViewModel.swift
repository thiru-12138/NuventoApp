//
//  DetailViewModel.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import Combine

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var info: IPInfo?
    
    private let service: DataService
    
    init(service: DataService) {
        self.service = service
    }
        
    // MARK: - Get PublicIP
    func fetchPublicIP() async throws -> String {
        let url = Constants.Urls.publicIP
        let result: IPResponse = try await service.fetchRequest(url: url)
        return result.ip
    }
    
    // MARK: - Get IP Info
    func fetchIPInfo(ip: String) async throws -> IPInfo {
        let url = Constants.Urls.getIPInfo + "\(ip)/geo"
        let result: IPInfo = try await service.fetchRequest(url: url)
        return result
    }

    // MARK: - IP Model
    func load() async {
        do {
            let ip = try await fetchPublicIP()
            info = try await fetchIPInfo(ip: ip)
        } catch {
            print(error)
        }
    }
}

