//
//  FavoritesViewControlelr.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

class FavoritesViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var postsTable: UITableView!
    ///////////////////////////////////////
    // MARK: Properties
    ///////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
    }
}
