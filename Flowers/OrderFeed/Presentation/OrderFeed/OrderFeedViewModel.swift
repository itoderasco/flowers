//
//  OrderFeedViewModel.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import Foundation
import Observation

protocol OrderFeedRouting: AnyObject {
    func showDetails(orderItem: OrderItem)
}

@Observable
final class OrderFeedViewModel {
    
    enum State {
        case idle
        case loading
        case loaded
        case failed
    }
    
    private(set) var state: State = .idle
    private(set) var items: [OrderItem] = []
    
    weak var router: OrderFeedRouting?
    
    private let repository: OrderRepository
    private let storage: OrderStorage
    
    init(repository: OrderRepository, storage: OrderStorage) {
        self.repository = repository
        self.storage = storage
    }
    
    func selectionHandler(item: OrderItem) {
        router?.showDetails(orderItem: item)
    }
    
    func prefetchData() {
        Task {
            let orders = await storage.getOrders()
            await setItems(from: orders)
        }
    }
    
    func fetchOrders() {
        Task {
            await updateState(.loading)
            
            do {
                let orders = try await repository.fetchOrders()
                await setItems(from: orders)
                await updateState(.loaded)
                
                await storage.store(orders)
            } catch {
                await updateState(.failed)
            }
        }
    }
    
    @MainActor
    private func setItems(from orders: [Order]) {
        items = orders.map(OrderItem.init)
    }
    
    @MainActor
    private func updateState(_ newState: State) {
        state = newState
    }
}
