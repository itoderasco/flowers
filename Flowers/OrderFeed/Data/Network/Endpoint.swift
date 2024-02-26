//
//  Endpoint.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

struct Endpoint {
    static let orders = OrdersEndpoint()
    static let customers = CustomersEndpoint()
}

struct OrdersEndpoint: BaseEndpoint {
    let path: String = "orders"
}

struct CustomersEndpoint: BaseEndpoint {
    let path: String = "customers"
}
