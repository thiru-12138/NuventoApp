//
//  DetailViewModel.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published var info: IPInfo?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let service: DataService
    private var task: Task<Void, Never>?
    
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
        task?.cancel()
        info = nil
        errorMessage = nil
        isLoading = true
        
        task = Task {
            do {
                let ip = try await fetchPublicIP()
                let infodetails = try await fetchIPInfo(ip: ip)
                await MainActor.run { [weak self] in
                    self?.info = infodetails
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.errorMessage = error.localizedDescription
                }
                print("ipinfo error: \(error.localizedDescription)")
            }
            
            await MainActor.run { [weak self] in
                self?.isLoading = false
            }
        }
    }
    
    deinit {
        task?.cancel()
    }
}

