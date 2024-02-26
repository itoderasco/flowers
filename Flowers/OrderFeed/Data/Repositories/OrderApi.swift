//
//  OrdersRepository.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

final class OrderApi: OrderRepository {
    
    private let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchOrders() async throws -> [Order] {
        let response: [OrderDTO] = try await network.getRequest(endpoint: Endpoint.orders)
        return response.map(OrderFactory.transform)
    }
}
