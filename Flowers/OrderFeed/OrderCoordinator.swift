//
//  OrderCoordinator.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import UIKit

final class OrderCoordinator: Coordinator {
    
    var rootController: UIViewController { navigation }
    
    private let network: NetworkService
    private let storage: OrderStorage
    private let navigation: UINavigationController
    
    init(network: NetworkService, storage: OrderStorage, navigation: UINavigationController) {
        self.network = network
        self.storage = storage
        self.navigation = navigation
    }
    
    func start() {
        let controller = OrderFeedBuilder.buildFeedController(
            network: network,
            storage: storage,
            router: self
        )
        navigation.pushViewController(controller, animated: false)
    }
}

extension OrderCoordinator: OrderFeedRouting {
    
    func showDetails(orderItem: OrderItem) {
        let controller = OrderDetailsBuilder.buildController(
            orderItem: orderItem,
            network: network,
            storage: storage
        )
        navigation.pushViewController(controller, animated: true)
    }
}
