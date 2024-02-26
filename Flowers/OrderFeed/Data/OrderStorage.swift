//
//  OrderStorage.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation

actor OrderStorage {
    
    private var orders = [Order]()
    private var customers = [Customer]()
    
    // MARK: - Orders
    
    func store(_ orders: [Order]) {
        self.orders = orders
    }
    
    func getOrders() -> [Order] {
        return orders
    }
    
    func getOrder(id: Int) -> Order? {
        return orders.first(where: { $0.id == id })
    }
    
    func updateOrder(id: Int, newStatus: OrderStatus) {
        guard let index = orders.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        let order = orders[index]
        
        guard order.status != newStatus else {
            return
        }
        
        let newOrder = OrderFactory.change(order, withNewStatus: newStatus)
        orders[index] = newOrder
    }
    
    // MARK: - Customers
    
    func store(_ customers: [Customer]) {
        self.customers = customers
    }
    
    func getCustomers() -> [Customer] {
        return customers
    }
    
    func getCustomer(id: Int) -> Customer? {
        return customers.first(where: { $0.id == id })
    }
}
