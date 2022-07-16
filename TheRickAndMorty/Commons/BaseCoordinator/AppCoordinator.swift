//
//  AppCoordinator.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 24/05/22.
//

import UIKit

final class AppCoordinator {
    var window: UIWindow
    var tabBarCoordinator: TabBarCoordinator!
    
    required init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        tabBarCoordinator = TabBarCoordinator(window: window)
        tabBarCoordinator.configTabBar()
    }
}
