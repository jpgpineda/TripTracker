//
//  UITextField+ext.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

extension UITextField {
    @IBInspectable var hintLocalized: String {
        set {
            placeholder = .Localized.getLocalizedString(newValue)
        }
        get {
            return placeholder ?? .empty
        }
    }
}
