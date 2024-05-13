//
//  CommentsConfigurator.swift
//  TripTracker
//
//  Created by javier pineda on 13/05/24.
//

import Foundation
import RealmSwift

protocol CommentsConfigurator {
    func configure() -> CommentsViewModel
}

class CommentsConfiguratorImplementation: CommentsConfigurator {
    @MainActor func configure() -> CommentsViewModel {
        // ApiClient
        let apiClient = ApiClient()
        // StorageContext
        let storageContext = StorageContextImplementation(realmDB: try! Realm())
        // ApiGateway
        let apiGateway = PostApiGatewayImplementation(apiClient: apiClient, storageContext: storageContext)
        // UseCase
        let useCase = PostUseCaseImplementation(apiGateway: apiGateway)
        // ViewModel
        return CommentsViewModel(useCase: useCase)
    }
}
