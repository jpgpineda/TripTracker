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
    @IBOutlet weak var postActionButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var savePostButton: UIButton!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postCommentsLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func savePost(_ sender: UIButton) {
        
    }
    
    @IBAction func makeActionOnPost(_ sender: UIButton) {
        
    }
}
