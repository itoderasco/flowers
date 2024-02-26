//
//  Coordinator.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var rootController: UIViewController { get }
    
    func start()
}
