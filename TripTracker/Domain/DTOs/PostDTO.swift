//
//  PostDTO.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

struct PostDTO {
    let description: String
    let image: String
    let likesCount, id: Int
    let user: UserDTO
    let actions: [String]
    let postedOn: Date
    let commets: [CommentDTO]
    var isLiked: Bool = false
    var isSaved: Bool = false
    
    var formattedPostDate: String {
        let calendar = Calendar.current
        return String(format: .Localized.postedOn, calendar.numberOfDaysBetween(postedOn, and: Date()))
    }
    
    var formattedComments: String {
        return String(format: .Localized.comments, commets.count)
    }
    
    init(with model: PostModel) {
        id = model.id
        description = model.postDescription
        image = model.image
        likesCount = model.likesCount
        user = UserDTO(with: model.userPost ?? UserModel())
        actions = Array(model.actions.map({
            return $0.name
        }))
        postedOn = model.postedOn
        commets = Array(model.commets).compactMap({
            CommentDTO(with: $0)
        })
    }
    
    init(with favoritePostModel: FavoritePostModel) {
        id = favoritePostModel.id
        description = favoritePostModel.postDescription
        image = favoritePostModel.image
        likesCount = favoritePostModel.likesCount
        user = UserDTO(with: favoritePostModel.userPost ?? UserModel())
        actions = Array(favoritePostModel.actions.map({
            return $0.name
        }))
        postedOn = favoritePostModel.postedOn
        commets = Array(favoritePostModel.commets).compactMap({
            CommentDTO(with: $0)
        })
    }
    
    init(with entity: Post) {
        id = entity.id
        description = entity.description
        image = entity.image
        likesCount = entity.likesCount
        user = UserDTO(with: entity.from)
        actions = Array(entity.actions.map({
            return $0.name.rawValue
        }))
        postedOn = entity.postedOn
        commets = entity.comments.compactMap({
            CommentDTO(with: $0)
        })
    }
}

struct CommentDTO {
    let id: Int
    let description: String
    let likesCount: Int
    let user: UserDTO
    let postedOn: Date
    var isLiked: Bool = false
    
    var formattedPostDate: String {
        let calendar = Calendar.current
        return String(format: .Localized.postedOn, calendar.numberOfDaysBetween(postedOn, and: Date()))
    }
    
    init(with model: CommentModel) {
        id = model.id
        description = model.commentDescription
        likesCount = model.likesCount
        user = UserDTO(with: model.user ?? UserModel())
        postedOn = model.postedOn
    }
    
    init(with entity: Comment) {
        id = entity.id
        description = entity.description
        likesCount = entity.likesCount
        user = UserDTO(with: entity.from)
        postedOn = entity.postedOn
    }
}

struct UserDTO {
    let id: Int
    let userName: String
    let userImageURL: String
    
    init(with model: UserModel) {
        id = model.id
        userName = model.userName
        userImageURL = model.userImageUrl
    }
    
    init(with entity: User) {
        id = entity.id
        userName = entity.userName
        userImageURL = entity.userImageURL
    }
    
    init() {
        self.id = .zero
        self.userName = .empty
        self.userImageURL = .empty
    }
}
