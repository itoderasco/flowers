//
//  OrderFeedBuilder.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import UIKit
import SwiftUI

final class OrderFeedBuilder {
    
    static func buildFeedController(network: NetworkService, storage: OrderStorage, router: OrderFeedRouting) -> UIViewController {
        let repository = OrderApi(network: network)
        let viewModel = OrderFeedViewModel(repository: repository, storage: storage)
        viewModel.router = router
        
        let rootView = OrderFeedView(viewModel: viewModel)
        
        let controller = UIHostingController(rootView: rootView)
        controller.title = "Orders"
        
        return controller
    }
}
