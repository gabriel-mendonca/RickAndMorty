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
    var navigation: NavigationController?
    var presentationType: PresentationType?
    
    var home: HomeCoordinator!
    var teste: RickAndMortyDetailsCoordinator!
    
    init(window: UIWindow) {
        self.window = window
        home = HomeCoordinator()
        teste = RickAndMortyDetailsCoordinator(id: 1)
        view = TabBarController()
    }
    
    func configTabBar() {
        window.rootViewController = view
        home.start(usingPresentation: .push(navigationController: NavigationController()), animated: true)
        teste.start(usingPresentation: .push(navigationController: NavigationController()), animated: true)
        view?.viewControllers = [home.navigation!, teste.navigation!]
        view?.tabBar.items?[0].title = "Home"
        view?.tabBar.items?[0].image = .iconHome
        view?.tabBar.items?[0].selectedImage = .iconHomeSelected
        
        view?.tabBar.items?[1].title = "Home"
        view?.tabBar.items?[1].image = .iconHome
        view?.tabBar.items?[1].selectedImage = .iconHomeSelected
    }
    
    func stop() {
//        view = nil
//        navigation = nil
//        presentationType = nil
    }
    
}
