//
//  NewPostViewController.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

class NewPostViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var selectPictureView: UIView!
    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addPostButton: UIButton!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
    }
    
    @IBAction func selectPicture(_ sender: UIButton) {
        
    }
    
    @IBAction func addNewPost(_ sender: UIButton) {
        
    }
}
