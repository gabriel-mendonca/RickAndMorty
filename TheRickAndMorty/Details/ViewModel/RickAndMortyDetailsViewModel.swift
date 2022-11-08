//
//  RickAndMortyDetailsViewModel.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 23/08/22.
//

import Foundation

class RickAndMortyDetailsViewModel {
    let id: Int
    weak var delegate: RickAndMortyDetailsViewModelDelegate?
    private var managerNetwork: RickAndMortyDetailsNetwork
    
    init(id: Int) {
        self.id = id
        self.managerNetwork = RickAndMortyDetailsNetwork()
    }
    
    func fetchDetails() {
        managerNetwork.getDetails(id: id) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.delegate?.didSuccess(data: data)
            case .failure(let error):
                if let error = error {
                    print("get charcaters details: \(error)")
                }
            }
        }
    }
}
