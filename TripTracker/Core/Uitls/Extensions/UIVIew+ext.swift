//
//  UIVIew+ext.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

extension UIView {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
        
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
