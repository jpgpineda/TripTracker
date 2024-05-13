//
//  CommentsViewController.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

class CommentsViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var addCommentTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    var comments: [CommentDTO] = [CommentDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        commentsTable.registerCell(CommentTableViewCell.identifier)
        commentsTable.dataSource = self
    }
    
    @IBAction func submitComment(_ sender: UIButton) {
        
    }
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        cell.setupView(comment: comments[indexPath.row])
        
        cell.cancellable = cell.likedButtonPressed.compactMap({$0}).sink(receiveValue: { _ in
            // TODO: Add logic to send request for like the post
        })
        return cell
    }
}
