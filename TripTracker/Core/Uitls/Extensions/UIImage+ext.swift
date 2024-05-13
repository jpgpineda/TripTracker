//
//  UIImage+ext.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func encodeToBase64() -> String {
        guard let imageData = self.pngData() else { return .empty }
        return imageData.base64EncodedString()
    }
}

extension UIImageView {
    func setupCircularImage() {
        self.layer.cornerRadius = self.frame.width / .two
        self.layer.borderWidth = .one
        self.layer.borderColor = UIColor.icon.cgColor
    }
}
