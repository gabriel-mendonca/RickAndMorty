//
//  RickAndMortyDetailsViewController.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 23/08/22.
//

import Foundation
import UIKit

enum characters: String {
    case alien
    case human
    case animal
    case robot
    case humanoid
    case disease
    case cronenberg
    case poopybutthole
    case mythologicalCreature
    case unknown
}

class RickAndMortyDetailsViewController: UIViewController {
    
    private var viewModel: RickAndMortyDetailsViewModel!
    
    private lazy var scrollViewDetail: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var imageViewPerson: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titlePerson: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 19)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var speciesPerson: UILabel = {
        let species = UILabel()
        species.textColor = .white
        species.font = UIFont.boldSystemFont(ofSize: 19)
        species.translatesAutoresizingMaskIntoConstraints = false
        return species
    }()
    
    private lazy var statusPerson: UILabel = {
        let status = UILabel()
        status.textColor = .white
        status.font = UIFont.boldSystemFont(ofSize: 19)
        status.translatesAutoresizingMaskIntoConstraints = false
            return status
        }()
        
    private lazy var locationPerson: UILabel = {
            let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
            return location
        }()
        
    private lazy var genderPerson: UILabel = {
        let gender = UILabel()
        gender.textColor = .white
        gender.font = UIFont.boldSystemFont(ofSize: 19)
        gender.translatesAutoresizingMaskIntoConstraints = false
        return gender
    }()
    
    init(viewModel: RickAndMortyDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        hideBottomTabBar(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchDetails()
    }
    
    func emotions(cases: DetailsModel) -> String {
        switch cases.species {
        case .alien:
            return "👽"
        case .human:
            return "👶🏻"
        case .animal:
            return "😼"
        case .robot:
            return "🤖"
        case .humanoid:
            return "👾"
        case .disease:
            return "🦠"
        case .cronenberg:
            return "❓"
        case .poopybutthole:
            return "❗️"
        case .mythologicalCreature:
            return "🐉"
        case .unknown:
            return ""
        case .none:
            return ""
        }
    }

    func populateData(data: DetailsModel) {
        DispatchQueue.main.async {
            self.title = data.name
            self.setupImageView(model: data)
            self.titlePerson.text = "Nome: \(data.name ?? "none")"
            self.speciesPerson.text = "Especie: \(data.species?.rawValue ?? "none") \(self.emotions(cases: data))"
            self.statusPerson.text = "Status: \(data.status?.rawValue ?? "none")"
            self.genderPerson.text = "Genero: \(data.gender?.rawValue ?? "none")"
        }
    }
}

extension RickAndMortyDetailsViewController {
    
    func setupConstraintsScroll() {
        scrollViewDetail.anchor(top: view.topAnchor,
                                left: view.leftAnchor,
                                bottom: view.bottomAnchor,
                                right: view.rightAnchor,
                                widthConstant: view.bounds.width)
    }
    
    func setupConstraintsImage() {
        imageViewPerson.anchor(top: scrollViewDetail.topAnchor,
                               left: scrollViewDetail.leftAnchor,
                               right: scrollViewDetail.rightAnchor,
                               widthConstant: view.bounds.width,
                               heightConstant: scrollViewDetail.bounds.height / 2)
    }
    
    func setupConstraintsTitle() {
        titlePerson.anchor(top: imageViewPerson.bottomAnchor,
                           left: scrollViewDetail.leftAnchor,
                           right: scrollViewDetail.rightAnchor,
                           topConstant: 12,
                           leftConstant: 16,
                           rightConstant: 16
                           )
    }
    
    func setupConstraintsSpecies() {
        speciesPerson.anchor(top: titlePerson.bottomAnchor,
                             left: scrollViewDetail.leftAnchor,
                             right: scrollViewDetail.rightAnchor,
                             topConstant: 12,
                             leftConstant: 16,
                             rightConstant: 16
                             )
    }
    
    func setupConstraintsStatus() {
        statusPerson.anchor(top: speciesPerson.bottomAnchor,
                            left: scrollViewDetail.leftAnchor,
                            right: scrollViewDetail.rightAnchor,
                            topConstant: 12,
                            leftConstant: 16,
                            rightConstant: 16)
    }
    
    func setupConstraintsGender() {
        genderPerson.anchor(top: statusPerson.bottomAnchor,
                            left: scrollViewDetail.leftAnchor,
                            bottom: scrollViewDetail.bottomAnchor,
                            right: scrollViewDetail.rightAnchor,
                            topConstant: 12,
                            leftConstant: 16,
                            bottomConstant: 12,
                            rightConstant: 16)
    }
    
    func setupImageView(model: DetailsModel) {
        guard let imageURL = model.image else { return }
        imageViewPerson.renderImageView(urlImage: imageURL)
    }
}

extension RickAndMortyDetailsViewController: ViewLayoutHelper {
    func buildViewHierarchy() {
        view.addSubview(scrollViewDetail)
        scrollViewDetail.addSubview(imageViewPerson)
        scrollViewDetail.addSubview(titlePerson)
        scrollViewDetail.addSubview(speciesPerson)
        scrollViewDetail.addSubview(statusPerson)
        scrollViewDetail.addSubview(genderPerson)
    }
    
    func setupContraints() {
        setupConstraintsScroll()
        setupConstraintsImage()
        setupConstraintsTitle()
        setupConstraintsSpecies()
        setupConstraintsStatus()
        setupConstraintsGender()
    }
    
    func setupAdditionalConfiguration() {
        
        viewModel.delegate = self
        view.backgroundColor = .black
    }
}
extension RickAndMortyDetailsViewController: RickAndMortyDetailsViewModelDelegate {
    func didSuccess(data: DetailsModel) {
        populateData(data: data)
    }
    
    
}
