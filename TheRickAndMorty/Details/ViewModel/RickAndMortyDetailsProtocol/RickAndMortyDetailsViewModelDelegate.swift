//
//  RickAndMortyDetailsViewModelDelegate.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 24/08/22.
//

import Foundation


protocol RickAndMortyDetailsViewModelDelegate: AnyObject {
    func didSuccess(data: DetailsModel)
}
