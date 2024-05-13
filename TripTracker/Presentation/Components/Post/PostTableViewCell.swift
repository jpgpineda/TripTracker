//
//  PostTableViewCell.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import UIKit
import Combine
import SDWebImage

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
    var isLiked: Bool = false
    var isSaved: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }
    
    func setupView(post: PostDTO) {
        postImage.layer.cornerRadius = .eight
        userImage.setupCircularImage()
        userNameLabel.text = post.user.userName
        postDescriptionLabel.text = post.description
        postCommentsLabel.text = post.formattedComments
        postDateLabel.text = post.formattedPostDate
        postImage.sd_setImage(with: post.imageURl)
        userImage.sd_setImage(with: post.user.imageUrl)
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
        isLiked = !isLiked
        button.setImage(isLiked ? UIImage(systemName: Constants.heartFilled) : UIImage(systemName: Constants.heart), for: .normal)
    }
    
    @IBAction func savePost(_ sender: UIButton) {
        isSaved = !isSaved
        sender.setImage(isSaved ? UIImage(systemName: Constants.bookmarkFilled) : UIImage(systemName: Constants.bookmark), for: .normal)
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
