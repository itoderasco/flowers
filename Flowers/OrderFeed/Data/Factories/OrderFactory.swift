//
//  OrderFactory.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

final class OrderFactory {
    
    static func transform(_ dto: OrderDTO) -> Order {
        return .init(
            id: dto.id,
            description: dto.description,
            price: dto.price,
            customerId: dto.customer_id,
            imageUrl: dto.image_url,
            status: map(rawStatus: dto.status)
        )
    }
    
    static func change(_ order: Order, withNewStatus status: OrderStatus) -> Order {
        return .init(
            id: order.id,
            description: order.description,
            price: order.price,
            customerId: order.customerId,
            imageUrl: order.imageUrl,
            status: status
        )
    }
    
    private static func map(rawStatus: String) -> OrderStatus {
        let status = OrderStatus(rawValue: rawStatus)
        return status ?? .invalidStatus
    }
}
