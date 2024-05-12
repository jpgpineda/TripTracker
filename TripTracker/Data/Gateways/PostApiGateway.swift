//
//  PostApiGateway.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

protocol PostApiGateway {
    var apiClient: ApiClient { get set }
    var storageContext: StorageContext { get set }
    func fetchPosts(parameters: FetchPostsRequest) async -> ApiResult<PostResponse>
    func getPosts() -> [PostModel]?
    func savePost(post: FavoritePostModel, completion: @escaping ModelOperationCompletionHandler)
    func getFavoritesPosts() -> [FavoritePostModel]?
}

class PostApiGatewayImplementation: PostApiGateway {
    internal var apiClient: ApiClient
    internal var storageContext: StorageContext
    
    init(apiClient: ApiClient, storageContext: StorageContext) {
        self.apiClient = apiClient
        self.storageContext = storageContext
    }
    
    func fetchPosts(parameters: FetchPostsRequest) async -> ApiResult<PostResponse> {
        guard let urlRequest = parameters.apiRequest else { return .failure(ApiError.unknown) }
        do {
            let response = try await apiClient.fetch(type: PostResponse.self, with: urlRequest)
            savePosts(posts: response.data)
            return .success(response)
        } catch {
            return .failure(ApiError.requestFailed(description: error.localizedDescription))
        }
    }
    
    private func savePosts(posts: [Post]) {
        let models = posts.compactMap {
            PostModel(with: $0)
        }
        storageContext.saveModels(models: models)
    }
    
    func savePost(post: FavoritePostModel, completion: @escaping ModelOperationCompletionHandler) {
        storageContext.saveModel(model: post, completion: completion)
    }
    
    func getFavoritesPosts() -> [FavoritePostModel]? {
        return storageContext.getModel(model: FavoritePostModel.self, predicate: nil) as? [FavoritePostModel]
    }
    
    func getPosts() -> [PostModel]? {
        return storageContext.getModel(model: PostModel.self, predicate: nil) as? [PostModel]
    }
}
