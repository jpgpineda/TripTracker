//
//  UITableView+ext.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

extension UITableView {
    func registerCell(_ identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil),
                      forCellReuseIdentifier: identifier)
    }
}
