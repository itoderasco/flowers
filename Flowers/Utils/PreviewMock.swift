//
//  PreviewMock.swift
//  Flowers
//
//  Created by Ion Toderasco on 26.02.2024.
//

import Foundation

#if DEBUG
struct PreviewMock {
    
    static let mockedOrderFeedVM = OrderFeedViewModel(
        repository: MockOrderRepo(),
        storage: OrderStorage()
    )
    
    static let mockedOrderDetailsVM = OrderDetailsViewModel(
        orderItem: orderItem,
        repository: MockCustomerRepo(),
        storage: OrderStorage()
    )
    
    private static let orderItem = OrderItem(order: .init(
        id: 1,
        description: "Rose",
        price: 20,
        customerId: 143,
        imageUrl: nil,
        status: .new
    ))
    
    private struct MockOrderRepo: OrderRepository {
        func fetchOrders() async throws -> [Order] {
            return [
                Order(id: 1, description: "Rose", price: 12, customerId: 1, imageUrl: nil, status: .new),
                Order(id: 2, description: "Rose", price: 12.0, customerId: 1, imageUrl: nil, status: .pending),
                Order(id: 3, description: "Rose", price: 12.5, customerId: 1, imageUrl: nil, status: .delivered)
            ]
        }
    }
    
    private struct MockCustomerRepo: CustomerRepository {
        func fetchCustomers() async throws -> [Customer] {
            return [
                Customer(id: 143, name: "Rick", coordinate: (0.0, 0.0))
            ]
        }
    }
}
#endif
