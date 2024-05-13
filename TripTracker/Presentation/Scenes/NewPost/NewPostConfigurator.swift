//
//  NewPostConfigurator.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import RealmSwift

protocol NewPostConfigurator {
    func configure() -> NewPostViewModel
}

class NewPostConfiguratorImplementation: NewPostConfigurator {
    @MainActor func configure() -> NewPostViewModel {
        // ApiClient
        let apiClient = ApiClient()
        // StorageContext
        let storageContext = StorageContextImplementation(realmDB: try! Realm())
        // ApiGateway
        let apiGateway = PostApiGatewayImplementation(apiClient: apiClient, storageContext: storageContext)
        // UseCase
        let useCase = PostUseCaseImplementation(apiGateway: apiGateway)
        // ViewModel
        return NewPostViewModel(useCase: useCase)
    }
}
