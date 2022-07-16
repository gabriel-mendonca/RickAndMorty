//
//  ViewLayoutHelper.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 24/05/22.
//

import Foundation

protocol ViewLayoutHelper {
    
    func buildViewHierarchy()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewLayoutHelper {
    func setupView() {
        buildViewHierarchy()
        setupContraints()
        setupAdditionalConfiguration()
    }
}
