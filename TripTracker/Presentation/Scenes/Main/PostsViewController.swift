//
//  WelcomeViewController.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import UIKit

class PostsViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var postsTable: UITableView!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    var posts: [PostDTO] = [PostDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        postsTable.registerCell(PostTableViewCell.identifier)
        postsTable.dataSource = self
    }
    
    @IBAction func addNewPost(_ sender: UIBarButtonItem) {
        
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        return cell
    }
}
