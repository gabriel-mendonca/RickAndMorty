//
//  HomeViewController.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 24/05/22.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!
    var result: [Results] = []
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        table.register(RickAndMortyTableViewCell.self, forCellReuseIdentifier: RickAndMortyTableViewCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "puxe para atualizar")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc
    private func refresh(_ sender: AnyObject) {
        viewModel.refreshPages()
        viewModel.fetchCharacters()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 375
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalItems = viewModel.results.count
        if indexPath.row > totalItems - 3 {
            viewModel.getMoreData()
        } else if totalItems == viewModel.model?.info.count {
            
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyTableViewCell.reuseIdentifier, for: indexPath) as? RickAndMortyTableViewCell else { return UITableViewCell() }
        let character = result[indexPath.row]
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
        title = " home"
        view.backgroundColor = .white
        
        viewModel.fetchCharacters()
        setupRefreshControl()
    }
    
    
}

extension HomeViewController: HomeViewModelDelegate {
    func didError(error: Error) {
        
    }
    
    func didSuccess(results: [Results]) {
        self.result = results
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}
