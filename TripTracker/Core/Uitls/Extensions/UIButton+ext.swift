//
//  UIButton+ext.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

extension UIButton {
    @IBInspectable var localized: String {
        set {
            setTitle(.Localized.getLocalizedString(newValue), for: .normal)
        }
        get {
            return title(for: .normal) ?? .empty
        }
    }
}
