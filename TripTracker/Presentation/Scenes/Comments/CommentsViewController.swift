//
//  CommentsViewController.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit
import Combine

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
    var postId: Int = .zero
    var comments: [CommentDTO] = [CommentDTO]()
    private let configurator = CommentsConfiguratorImplementation()
    private var viewModel: CommentsViewModel?
    private var cancelBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = configurator.configure()
        setupView()
    }
    
    private func setupView() {
        commentsTable.registerCell(CommentTableViewCell.identifier)
        commentsTable.dataSource = self
        addCommentTextField.delegate = self
        bind()
    }
    
    private func bind() {
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
        
        viewModel?.output.resetForm.sink(receiveValue: { [weak self] _ in
            self?.addCommentTextField.text = .empty
            self?.validateFields()
        }).store(in: &cancelBag)
    }
    
    @IBAction func submitComment(_ sender: UIButton) {
        viewModel?.input.addNewComment.send(postId)
    }
    
    private func validateFields() {
        guard let viewModel = viewModel else { return }
        submitButton.isEnabled = viewModel.validateFields()
        submitButton.tintColor = viewModel.validateFields() ? .icon : .secundaryText
    }
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        let comment = comments[indexPath.row]
        cell.setupView(comment: comment)
        
        cell.cancellable = cell.likedButtonPressed.compactMap({$0}).sink(receiveValue: { [weak self] _ in
            guard let viewModel = self?.viewModel else { return }
            viewModel.input.addLikeToComment.send(CommentIdentity(postId: self?.postId ?? .zero,
                                                                  commetId: comment.id))
        })
        return cell
    }
}

extension CommentsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel?.input.updateComment.send(textField.text ?? .empty)
        validateFields()
    }
}
