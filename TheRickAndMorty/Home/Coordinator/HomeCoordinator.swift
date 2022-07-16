//
//  HomeCoordinator.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 24/05/22.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    var view: HomeViewController?
    var navigation: UINavigationController?
    var presentationType: PresentationType?
    
    var homeViewModel: HomeViewModel
    
    init() {
        homeViewModel = HomeViewModel()
        view = HomeViewController(viewModel: homeViewModel)
        
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
}
