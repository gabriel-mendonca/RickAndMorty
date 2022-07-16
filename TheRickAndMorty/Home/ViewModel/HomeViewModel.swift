//
//  HomeViewModel.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 24/05/22.
//

import UIKit

class HomeViewModel {
    
    var model: Character?
    var statusObservable: Observable<RequestStates<Character>>
    
    init() {
        self.statusObservable = Observable(RequestStates.loading)
    }
    
    func fillCharacters(page: Int) -> Int {
        guard let result = model?.results.count else { return 0 }
        for i in 0..<result {
            guard let pages = model?.info.next else { return 0 }
        }
        return page
    }
    
    func numberOfCharacters() -> Int {
        model?.results.count ?? 0
    }
    
    internal func fetchCharacters(env: API.Enviroment? = nil) {
        API(withEnviroment: env).homeService.getCharactersList(page: 0) { [weak self] (response) in
            guard let self = self else { return }
            self.model = response
            self.statusObservable.value = .load(data: response)
        } onFailure: { (error) in
            self.statusObservable.value = .errored(error: error)
        }
    }
}
