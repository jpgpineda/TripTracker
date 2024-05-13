//
//  PostUseCase.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

protocol PostUseCase {
    var apiGateway: PostApiGateway { get set }
    func fetchPosts(parameters: FetchPostsRequest) async -> ApiResult<[PostDTO]>
    func getPosts() -> [PostDTO]?
    func savePost(post: FavoritePostModel, completion: @escaping ModelOperationCompletionHandler)
    func getFavoritesPosts() -> [PostDTO]?
    func createNewPost(parameters: AddNewPostRequest) async -> ApiResult<String>
    func addNewComment(parameters: AddNewCommentRequest) async -> ApiResult<String>
    func addLikeToComment(parameters: AddLikeToCommentRequest) async -> ApiResult<String>
}

class PostUseCaseImplementation: PostUseCase {
    var apiGateway: PostApiGateway
    
    init(apiGateway: PostApiGateway) {
        self.apiGateway = apiGateway
    }
    
    func fetchPosts(parameters: FetchPostsRequest) async -> ApiResult<[PostDTO]> {
        let response = await apiGateway.fetchPosts(parameters: parameters)
        switch response {
        case .success(let posts):
            return .success(posts.data.compactMap({
                PostDTO(with: $0)
            }))
        case .failure(let apiError):
            return .failure(apiError)
        }
    }
    
    func getPosts() -> [PostDTO]? {
        guard let posts = apiGateway.getPosts(),
              !posts.isEmpty else { return nil }
        return posts.compactMap {
            PostDTO(with: $0)
        }
    }
    
    func savePost(post: FavoritePostModel, completion: @escaping ModelOperationCompletionHandler) {
        apiGateway.savePost(post: post, completion: completion)
    }
    
    func getFavoritesPosts() -> [PostDTO]? {
        guard let posts = apiGateway.getFavoritesPosts(),
              !posts.isEmpty else { return nil }
        return posts.compactMap {
            PostDTO(with: $0)
        }
    }
    
    func createNewPost(parameters: AddNewPostRequest) async -> ApiResult<String> {
        return await apiGateway.createNewPost(parameters: parameters)
    }
    
    func addNewComment(parameters: AddNewCommentRequest) async -> ApiResult<String> {
        return await apiGateway.addComment(parameters: parameters)
    }
    
    func addLikeToComment(parameters: AddLikeToCommentRequest) async -> ApiResult<String> {
        return await apiGateway.addLikeToComment(parameters: parameters)
    }
}
