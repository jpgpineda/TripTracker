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
                         isCancelAnOption: Bool = false) {
        
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
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: .Localized.atenttion,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: .Localized.confirm,
                                      style: .default))
        
        present(alert, animated: true)
    }
    
    func showLoader() {
        guard let viewController = ModuleManager.shared.toolsDependency.makeLoaderViewController() else { return }
        addChild(viewController)
        guard let loaderView = viewController.view else { return }
        loaderView.tag = 100
        view.addSubview(loaderView)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    func dismissLoader() {
        DispatchQueue.main.async {
            guard let loaderView = self.view.viewWithTag(100) else { return }
            loaderView.removeFromSuperview()
        }
    }
}
