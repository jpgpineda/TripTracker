//
//  FavoritesViewControlelr.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit
import Combine

class FavoritesViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var postsTable: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    private let configurator = FavoritesConfiguratorImplementation()
    private var viewModel: FavoritesViewModel?
    private var cancelBag = Set<AnyCancellable>()
    private var posts: [PostDTO] = [PostDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = configurator.configure()
        setupView()
    }
    
    private func setupView() {
        postsTable.registerCell(PostTableViewCell.identifier)
        postsTable.dataSource = self
        bind()
    }
    
    private func bind() {
        viewModel?.input.viewDidLoad.send()
        
        viewModel?.output.showLoader.sink(receiveValue: { [weak self] isShowing in
            if isShowing {
                self?.showLoader()
            } else {
                self?.dismissLoader()
            }
        }).store(in: &cancelBag)
        
        viewModel?.output.showMessage.sink(receiveValue: { [weak self] message in
            self?.showMessage(message: message)
        }).store(in: &cancelBag)
        
        viewModel?.output.updatePosts.sink(receiveValue: { [weak self] posts in
            self?.posts = posts
            self?.postsTable.reloadData()
            //self?.emptyLabel.isHidden = true
        }).store(in: &cancelBag)
            
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = posts[indexPath.row]
        cell.setupView(post: post)
        
        cell.savedButtonPressed.sink { [weak self] _ in
            self?.viewModel?.input.deleteFavorite.send(post)
        }.store(in: &cancelBag)
        return cell
    }
}
