//
//  UILabel+exr.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

extension UILabel {
    @IBInspectable var localized: String {
        set {
            text = .Localized.getLocalizedString(newValue)
        }
        get {
            return text ?? .empty
        }
    }
}
