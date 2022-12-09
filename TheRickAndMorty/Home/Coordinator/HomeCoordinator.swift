//
//  HomeCoordinator.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 24/05/22.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    var view: HomeViewController?
    var navigation: NavigationController?
    var presentationType: PresentationType?
    
    var homeViewModel: HomeViewModel
    
    private var rickAndMortyDetailCoordinator: RickAndMortyDetailsCoordinator!
    
    init() {
        homeViewModel = HomeViewModel()
        homeViewModel.coordinatorDelegate = self
        view = HomeViewController(viewModel: homeViewModel)
        
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
    
    func goRickAndMortyDetails(id: Int) {
        guard let navigation = navigation else { return }
        rickAndMortyDetailCoordinator = RickAndMortyDetailsCoordinator(id: id)
        rickAndMortyDetailCoordinator.start(usingPresentation: .push(navigationController: navigation), animated: true)
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func sendToDetail(id: Int) {
        goRickAndMortyDetails(id: id)
    }
    
    
}
