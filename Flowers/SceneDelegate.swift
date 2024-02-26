//
//  SceneDelegate.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var root: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        windowScene.delegate = self
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let coordinator = AppCoordinator(window: window)
        coordinator.start()
        
        self.root = coordinator
    }
}
