//
//  FavoritesCoordinator.swift
//  TripTracker
//
//  Created by javier pineda on 13/05/24.
//

import RealmSwift

protocol FavoritesConfigurator {
    func configure() -> FavoritesViewModel
}

class FavoritesConfiguratorImplementation: FavoritesConfigurator {
    func configure() -> FavoritesViewModel {
        // ApiClient
        let apiClient = ApiClient()
        // StorageContext
        let storageContext = StorageContextImplementation(realmDB: try! Realm())
        // ApiGateway
        let apiGateway = PostApiGatewayImplementation(apiClient: apiClient, storageContext: storageContext)
        // UseCase
        let useCase = PostUseCaseImplementation(apiGateway: apiGateway)
        // ViewModel
        return FavoritesViewModel(useCase: useCase)
    }
}
 
