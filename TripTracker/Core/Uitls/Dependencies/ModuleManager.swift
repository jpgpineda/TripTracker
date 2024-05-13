//
//  ModuleManager.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import Swinject

class ModuleManager {
    let toolsDependency: ToolsDependency
    let postDependency: PostDependency
    
    static var shared: ModuleManager = {
        return ModuleManager(container: Container())
    }()
    
    private init(container: Container) {
        self.toolsDependency = ToolsDependencyImplementation(container: container)
        self.postDependency = PostDependencyImplementation(container: container)
    }
}
