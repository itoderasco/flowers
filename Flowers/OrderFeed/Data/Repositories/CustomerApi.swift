//
//  CustomerApi.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

final class CustomerApi: CustomerRepository {
    
    private let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchCustomers() async throws -> [Customer] {
        let response: [CustomerDTO] = try await network.getRequest(endpoint: Endpoint.customers)
        return response.map(CustomerFactory.transform)
    }
}
