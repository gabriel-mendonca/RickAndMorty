//
//  RickAndMortyTableViewCell.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 26/05/22.
//

import UIKit

final class RickAndMortyTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "homeRickAndMortyCell"
    lazy var card = RickAndMortyCard()
    
    internal func setupCell(model: Results) {
        self.card.setupCard(image: model.image ?? "",
                            name: model.name?.uppercased() ?? "",
                            status: model.status?.rawValue ?? "" ,
                            species: model.species?.rawValue ?? "")
        }
}

extension RickAndMortyTableViewCell: ViewLayoutHelper {
    func buildViewHierarchy() {
        contentView.addSubview(card)
    }
    
    func setupContraints() {
        card.anchor(top: self.topAnchor,
                    left: self.leftAnchor,
                    bottom: self.bottomAnchor,
                    right: self.rightAnchor,
                    topConstant: 30,
                    leftConstant: 30,
                    bottomConstant: 30,
                    rightConstant: 30)
    }
    
    func setupAdditionalConfiguration() {
        contentView.backgroundColor = .black
    }
    
    
}
