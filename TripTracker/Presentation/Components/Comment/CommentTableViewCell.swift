//
//  CommentTableViewCell.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit
import Combine
import SDWebImage

class CommentTableViewCell: UITableViewCell {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postDateLabel: UILabel!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    static let identifier = "CommentTableViewCell"
    var cancellable: AnyCancellable?
    let likedButtonPressed = PassthroughSubject<Void, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(comment: CommentDTO) {
        userImage.sd_setImage(with: comment.user.imageUrl)
        userNameLabel.text = comment.user.userName
        descriptionLabel.text = comment.description
        postDateLabel.text = comment.formattedPostDate
    }
    
    @IBAction func likePost(_ sender: UIButton) {
        likedButtonPressed.send()
    }
}
