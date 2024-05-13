//
//  UITextView+ext.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

extension UITextView {
    @IBInspectable var hintLocalized: String {
        set {
            text = .Localized.getLocalizedString(newValue)
            textColor = .secundaryText
        }
        get {
            return text ?? .empty
        }
    }
}
