//
//  PostsConfigurator.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import RealmSwift

protocol PostsConfigurator {
    func configure() -> PostsViewModel
}

class PostsConfiguratorImplementation: PostsConfigurator {
    @MainActor func configure() -> PostsViewModel {
        // ApiClient
        let apiClient = ApiClient()
        // StorageContext
        let storageContext = StorageContextImplementation(realmDB: try! Realm())
        // ApiGateway
        let apiGateway = PostApiGatewayImplementation(apiClient: apiClient, storageContext: storageContext)
        // UseCase
        let useCase = PostUseCaseImplementation(apiGateway: apiGateway)
        // ViewModel
        return PostsViewModel(useCase: useCase)
    }
}
