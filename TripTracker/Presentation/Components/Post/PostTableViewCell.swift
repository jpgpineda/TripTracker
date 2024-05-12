//
//  PostTableViewCell.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var savePostButton: UIButton!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postCommentsLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    static let identifier = "PostTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(post: PostDTO) {
        userNameLabel.text = post.user.userName
        postDescriptionLabel.text = post.description
        postCommentsLabel.text = post.formattedComments
        postDateLabel.text = post.formattedPostDate
    }

    @IBAction func savePost(_ sender: UIButton) {
        sender.setImage(sender.isSelected ? UIImage(systemName: Constants.bookmarkFilled) : UIImage(systemName: Constants.bookmark), for: .normal)
    }
    
    @IBAction func moreActionsPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func makeActionOnPost(_ sender: UIButton) {
        switch sender.tag {
        case .zero:
            sender.setImage(sender.isSelected ? UIImage(systemName: Constants.heartFilled) : UIImage(systemName: Constants.heart), for: .normal)
        // TODO: add remaining cases
        default:
            break
            
        }
    }
}
