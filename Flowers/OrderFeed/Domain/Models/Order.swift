//
//  Order.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

struct Order {
    let id: Int
    let description: String
    let price: Double
    let customerId: Int
    let imageUrl: URL?
    let status: OrderStatus
}

enum OrderStatus: String {
    case new
    case pending
    case delivered
    
    /// Unknown / new or invalid statuses
    case invalidStatus
    
    func next() -> OrderStatus? {
        switch self {
        case .new: return .pending
        case .pending: return .delivered
        default: return nil
        }
    }
}

struct OrderItem: Identifiable {
    let id: Int
    
    let title: String
    let imageUrl: URL?
    let status: OrderStatus
    
    let price: Double
    let formattedPrice: String
    
    init(order: Order) {
        id = order.id
        title = order.description
        imageUrl = order.imageUrl
        status = order.status
        price = order.price
        formattedPrice = String(format: "%.2f RON", price)
    }
}

struct OrderItemDetails {
    private let order: OrderItem
    private let customer: Customer?
    
    var orderId: Int { order.id }
    
    var title: String { order.title }
    
    var status: OrderStatus { order.status }
    
    var imageURL: URL? { order.imageUrl }
    
    var formattedPrice: String { order.formattedPrice }
    
    var customerName: String { customer?.name ?? "n/a" }
    
    var customerLocationCoordinate: (lat: Double, lon: Double)? {
        customer?.coordinate
    }        
    
    init(order: OrderItem, customer: Customer? = nil) {
        self.order = order
        self.customer = customer
    }
}
