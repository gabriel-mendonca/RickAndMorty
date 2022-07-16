//
//  TabBarCoordinator.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 25/05/22.
//

import UIKit

class TabBarCoordinator: BaseCoordinator {
    
    var window: UIWindow
    var view: TabBarController?
    var navigation: UINavigationController?
    var presentationType: PresentationType?
    
    var home: HomeCoordinator!
    
    init(window: UIWindow) {
        self.window = window
        home = HomeCoordinator()
        view = TabBarController()
    }
    
    func configTabBar() -> UITabBarController {
        window.rootViewController = view
        home.start(usingPresentation: .push(navigationController: UINavigationController()), animated: true)
        view?.viewControllers = [home.navigation!]
        view?.tabBar.items?[0].title = "Home"
        view?.tabBar.items?[0].image = .iconHome
        view?.tabBar.items?[0].selectedImage = .iconHomeSelected
        return view!
    }
    
    func stop() {
//        view = nil
//        navigation = nil
//        presentationType = nil
    }
    
}
