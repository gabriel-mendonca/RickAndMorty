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
    private var loadingName: String!
    private var loadingAnimation: LoadingAnimation!
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        refreshControl = UIRefreshControl()
        loadingName = "LoadingScience"
        loadingAnimation = LoadingAnimation(nameJson: loadingName,
                                            animationHeight: 80,
                                            animationWidht: view.bounds.width)
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
    
    private func configFooterView(_ tableView: UITableView) {
        tableView.tableFooterView?.frame = CGRect(
            x: 0,
            y: 30,
            width: tableView.bounds.width,
            height: 70
        )
        tableView.tableFooterView = loadingAnimation
        tableView.tableFooterView?.backgroundColor = .black
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 375
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalItems = viewModel.results.count
        if indexPath.row > totalItems - 2 {
            configFooterView(tableView)
            loadingAnimation.startProgressLoading()
            viewModel.getMoreData()
            tableView.reloadData()
            loadingAnimation.endProgressLoading()
            tableView.tableFooterView?.isHidden = true
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = result[indexPath.row].id else { return }
        viewModel.goToDetails(id: id)
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
        loadingAnimation.endProgressLoading()
    }
    
    func didSuccess(results: [Results]) {
        self.result = results
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}
