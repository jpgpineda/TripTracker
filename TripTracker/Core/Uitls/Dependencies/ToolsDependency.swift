//
//  ToolsDependency.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import Swinject

protocol ToolsDependency {
    var container: Container { get set }
    func makeLoaderViewController() -> LoaderViewController?
}

class ToolsDependencyImplementation: ToolsDependency {
    var container: Container
    
    init(container: Container) {
        self.container = container
        registerLoaderViewController()
    }
    
    private func registerLoaderViewController() {
        container.register(LoaderViewController.self) { _ in
            return LoaderViewController()
        }
    }
    
    func makeLoaderViewController() -> LoaderViewController? {
        return container.resolve(LoaderViewController.self)
    }
}
