//
//  OrderDetailsBuilder.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import UIKit
import SwiftUI

final class OrderDetailsBuilder {
    
    static func buildController(orderItem: OrderItem, network: NetworkService, storage: OrderStorage) -> UIViewController {
        let repository = CustomerApi(network: network)
        let viewModel = OrderDetailsViewModel(
            orderItem: orderItem,
            repository: repository,
            storage: storage
        )
        let rootView = OrderDetailsView(viewModel: viewModel)
        
        let controller = UIHostingController(rootView: rootView)
        controller.title = "Order Details"
        
        return controller
    }
}
