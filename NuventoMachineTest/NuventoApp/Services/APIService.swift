//
//  APIService.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import Foundation

// MARK: - Protocol
protocol DataService {
    func fetchRequest<T: Codable>(url: String) async throws -> T
}

// MARK: - Network Service
final class APIService: DataService {
    func fetchRequest<T>(url: String) async throws -> T where T : Decodable, T : Encodable {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                throw URLError(.init(rawValue: httpResponse.statusCode))
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch {
                throw URLError(.cannotParseResponse)
            }
        } catch {
            throw URLError(.badServerResponse)
        }
    }
}
