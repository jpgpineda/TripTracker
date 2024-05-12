//
//  UIVIewController+Ext.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import UIKit

extension UIViewController {
    func showConfimation(title: String,
                         message: String,
                         cancel: String?,
                         confirm: String,
                         confirmAction:  @escaping() -> Void,
                         isCancelAnOption: Bool) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        
        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel,
                                          style: isCancelAnOption ? .default : .destructive,
                                          handler: nil))
        }
        
        alert.addAction(UIAlertAction(title: confirm,
                                      style: isCancelAnOption ? .destructive : .default,
                                      handler: { (action) in
                                        
                                        confirmAction()
                                        
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
