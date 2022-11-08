//
//  HomeViewModelProtocol.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 23/08/22.
//

import Foundation


protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func sendToDetail(id: Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func didSuccess(results: [Results])
    func didError(error: Error)
}
