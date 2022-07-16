//
//  HomeViewController.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 24/05/22.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " home"
        view.backgroundColor = .red
        setupView()
        requestListener()
        viewModel.fetchCharacters()
        tableView.reloadData()
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .blue
        table.dataSource = self
        table.delegate = self
        table.register(RickAndMortyTableViewCell.self, forCellReuseIdentifier: RickAndMortyTableViewCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func requestListener() {
        viewModel.statusObservable.didChange = { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.config(state: response)
            }
        }
    }
    
    func config(state: RequestStates<Character>) {
        switch state {
        case .loading:
            print("loading...")
        case .load(data: let characters):
            self.viewModel.model = characters
            self.tableView.reloadData()
        default:
            break
        }
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyTableViewCell.reuseIdentifier, for: indexPath) as? RickAndMortyTableViewCell else { return UITableViewCell() }
        guard let character = viewModel.model?.results[indexPath.row] else { return UITableViewCell()}
        cell.setupView()
        cell.setupCell(model: character)
        return cell
    }
}

extension HomeViewController: ViewLayoutHelper {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupContraints() {
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}
