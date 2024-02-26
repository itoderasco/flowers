//
//  AppCoordinator.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import UIKit

enum AppFeature {
    case orders
}

final class AppCoordinator: Coordinator {
    
    var rootController: UIViewController { navigation }
    
    private let window: UIWindow
    
    private let navigation = UINavigationController()
    private var childs = [AppFeature: Coordinator]()

    private let network: MainNetworkService
    private let storage: OrderStorage
    
    init(window: UIWindow) {
        self.window = window
        
        network = .init(baseStringUrl: Config.baseStringUrl)
        storage = .init()
    }
    
    func start() {
        let coordinator = OrderCoordinator(
            network: network,
            storage: storage,
            navigation: navigation
        )
        childs[.orders] = coordinator
        coordinator.start()
        
        window.rootViewController = coordinator.rootController
        window.makeKeyAndVisible()
    }
}
