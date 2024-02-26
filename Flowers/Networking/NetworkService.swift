//
//  NetworkService.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

protocol NetworkService {
    func getRequest<T: Decodable>(endpoint: BaseEndpoint) async throws -> T
}

final class MainNetworkService: NetworkService {

    private let baseStringUrl: String
    
    init(baseStringUrl: String) {
        self.baseStringUrl = baseStringUrl
    }
    
    func getRequest<T: Decodable>(endpoint: BaseEndpoint) async throws -> T {
        guard let url = URL(string: baseStringUrl.appending(endpoint.path)) else {
            throw NetworkError.invalidURL
        }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
