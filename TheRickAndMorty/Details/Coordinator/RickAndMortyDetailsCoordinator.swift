//
//  RickAndMortyDetailsCoordinator.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 23/08/22.
//

import Foundation
import UIKit


class RickAndMortyDetailsCoordinator: BaseCoordinator {
    
    var view: RickAndMortyDetailsViewController?
    var navigation: NavigationController?
    var presentationType: PresentationType?
    
    private var viewModel: RickAndMortyDetailsViewModel!
    
    init(id: Int) {
        viewModel = RickAndMortyDetailsViewModel(id: id)
        view = RickAndMortyDetailsViewController(viewModel: viewModel)
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
    }
}
