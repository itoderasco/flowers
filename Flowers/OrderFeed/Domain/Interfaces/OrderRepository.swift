//
//  OrderRepository.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

protocol OrderRepository {
    func fetchOrders() async throws -> [Order]
}
