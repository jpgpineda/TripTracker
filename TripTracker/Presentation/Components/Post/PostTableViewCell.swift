//
//  PostTableViewCell.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import UIKit
import Combine

class PostTableViewCell: UITableViewCell {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var savePostButton: UIButton!
    @IBOutlet weak var likePostButton: UIButton!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postCommentsLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    static let identifier = "PostTableViewCell"
    var cancellables = Set<AnyCancellable>()
    let moreActionsPressed = PassthroughSubject<Void, Never>()
    let savedButtonPressed = PassthroughSubject<Void, Never>()
    let commentsButtonPressed = PassthroughSubject<Void, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }
    
    func setupView(post: PostDTO) {
        userNameLabel.text = post.user.userName
        postDescriptionLabel.text = post.description
        postCommentsLabel.text = post.formattedComments
        postDateLabel.text = post.formattedPostDate
        setupGestureForComments()
        setupGestureForImage()
    }
    
    private func setupGestureForComments() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        postCommentsLabel.isUserInteractionEnabled = true
        postCommentsLabel.addGestureRecognizer(labelTap)
    }
    
    private func setupGestureForImage() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        imageTap.numberOfTapsRequired = .two
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(imageTap)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        commentsButtonPressed.send()
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        handleLikeState(button: likePostButton)
    }
    
    private func handleLikeState(button: UIButton) {
        button.setImage(button.isSelected ? UIImage(systemName: Constants.heartFilled) : UIImage(systemName: Constants.heart), for: .normal)
    }
    
    @IBAction func savePost(_ sender: UIButton) {
        sender.setImage(sender.isSelected ? UIImage(systemName: Constants.bookmarkFilled) : UIImage(systemName: Constants.bookmark), for: .normal)
        savedButtonPressed.send()
    }
    
    @IBAction func moreActionsPressed(_ sender: UIButton) {
        moreActionsPressed.send()
    }
    
    @IBAction func makeActionOnPost(_ sender: UIButton) {
        switch sender.tag {
        case .zero:
            handleLikeState(button: sender)
        case .one:
            commentsButtonPressed.send()
        default:
            break
        }
    }
}
