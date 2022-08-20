//
//  HomeViewModel.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 24/05/22.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func didSuccess(results: [Results])
    func didError(error: Error)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    private let manager = HomeServiceApi()
    var model: Character?
    var results: [Results] = []
    var hasResquestInProgress = false
    var pages = 1
    
    init() {
        
    }
    
    internal func fetchCharacters() {
        guard !hasResquestInProgress else { return }
        hasResquestInProgress = true
        manager.getCharacter(page: pages) { [weak self] (responses) in
            guard let self = self else { return }
            switch responses {
            case .success(let data):
                self.model = data
                self.results.append(contentsOf: data.results ?? [])
                self.delegate?.didSuccess(results: self.results)
                self.pages += 1
            case .failure(let error):
                if let error = error {
                print("get characters: \(error)")
                }
            }
        }
        self.hasResquestInProgress = false
    }
    
    internal func getMoreData() {
        guard getNumberPage() >= self.pages else { return }
        fetchCharacters()
    }
    
    internal func getNumberPage() -> Int {
        return model?.info.pages ?? 0
    }
    
    func refreshPages() {
        pages = 1
        results.removeAll()
    }
}
