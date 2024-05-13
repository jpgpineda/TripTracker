//
//  WelcomeViewController.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import UIKit
import Combine

class PostsViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var postsTable: UITableView!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    var posts: [PostDTO] = [PostDTO]()
    private var cancelBag = Set<AnyCancellable>()
    private var viewModel: PostsViewModel?
    private let configurator = PostsConfiguratorImplementation()
    
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
        }).store(in: &cancelBag)
    }
    
    @IBAction func addNewPost(_ sender: UIBarButtonItem) {
        guard let viewController = ModuleManager.shared.postDependency.makeNewPostViewController() else { return }
        navigationController?.present(viewController, animated: true)
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = posts[indexPath.row]
        cell.setupView(post: post)
        
        cell.savedButtonPressed.sink { [weak self] _ in
            self?.viewModel?.input.savePost.send(post)
        }.store(in: &cell.cancellables)
        
        cell.commentsButtonPressed.sink { [weak self] _ in
            guard let viewController = ModuleManager.shared.postDependency.makeCommentsViewController(postId: post.id,
                                                                                                      comments: post.commets) else { return }
            self?.navigationController?.present(viewController, animated: true)
        }.store(in: &cell.cancellables)
        
        cell.moreActionsPressed.sink { [weak self] _ in
            self?.showConfimation(title: .Localized.reportPost,
                                  message: .empty,
                                  cancel: .Localized.cancel,
                                  confirm: .Localized.report,
                                  confirmAction: {
                self?.showMessage(message: .Localized.postReported)
            }, isCancelAnOption: true)
        }.store(in: &cell.cancellables)
        
        return cell
    }
}
