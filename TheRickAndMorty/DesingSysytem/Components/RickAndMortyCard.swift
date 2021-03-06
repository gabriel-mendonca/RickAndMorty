//
//  RickAndMortyCard.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 26/05/22.
//

import UIKit

class RickAndMortyCard: UIView {
    
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var viewCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var charactersImage: UIImageView = {
        let characters = UIImageView()
        characters.contentMode = .scaleAspectFill
        characters.translatesAutoresizingMaskIntoConstraints = false
        return characters
    }()
    
    private lazy var charactersName: UILabel = {
        let name = UILabel()
        return name
    }()
    
    private lazy var charactersStatus: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    private lazy var characterSpecies: UILabel = {
        let species = UILabel()
        species.translatesAutoresizingMaskIntoConstraints = false
        return species
    }()
    
    private lazy var localizationCharacters: UILabel = {
        let localization = UILabel()
        localization.text = "localization"
        localization.translatesAutoresizingMaskIntoConstraints = false
        return localization
    }()
    
    private func viewConfiguration() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    internal func setupCard(image: String, name: String, status: String, species: String) {
        setupImageView(urlImage: image)
        charactersName.text = name
        charactersStatus.text = status
        characterSpecies.text = species
    }
}

extension RickAndMortyCard {
    
    private func setupContrantsViewCard() {
        viewCard.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor)
    }
    
    private func setupConstraintsCharactersImage() {
        charactersImage.anchor(
            top: viewCard.topAnchor,
            left: viewCard.leftAnchor,
            right: viewCard.rightAnchor,
            heightConstant: 50)
    }
    
    private func setupConstraintsCharacterName() {
        charactersName.anchor(
            top: charactersImage.bottomAnchor,
            left: viewCard.leftAnchor,
            right: viewCard.rightAnchor,
            topConstant: 15,
            leftConstant: 16)
    }
    
    private func setupConstraintsCharacterStatus() {
        charactersStatus.anchor(
            top: charactersName.bottomAnchor,
            left: viewCard.leftAnchor,
            right: viewCard.rightAnchor,
            topConstant: 15,
            leftConstant: 16,
            rightConstant: 16)
    }
    
    private func setupConstraintsCharacterSpecies() {
        characterSpecies.anchor(
            top: charactersStatus.bottomAnchor,
            left: viewCard.leftAnchor,
            right: viewCard.rightAnchor,
            topConstant: 15,
            leftConstant: 16,
            rightConstant: 16)
    }
    
    internal func setupImageView(urlImage: String) {
        if let urlPhoto = URL(string: urlImage) {
            URLSession.shared.dataTask(with: urlPhoto) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    let image = UIImage(data: data)
                    self.charactersImage.image = image
                }
            }.resume()
        }
        
    }
}

extension RickAndMortyCard: ViewLayoutHelper {
    func buildViewHierarchy() {
        addSubview(viewCard)
        viewCard.addSubview(charactersImage)
        viewCard.addSubview(charactersName)
        viewCard.addSubview(charactersStatus)
        viewCard.addSubview(characterSpecies)
    }
    
    func setupContraints() {
        setupContrantsViewCard()
        setupConstraintsCharactersImage()
        setupConstraintsCharacterName()
        setupConstraintsCharacterStatus()
        setupConstraintsCharacterSpecies()
    }
    
    func setupAdditionalConfiguration() {
        viewConfiguration()
        backgroundColor = .white
    }
    
    
}
