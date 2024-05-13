//
//  PostModel.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation
import RealmSwift

class PostModel: Object {
    @Persisted(primaryKey: true) var id: Int = .zero
    @Persisted var postDescription: String = .empty
    @Persisted var image: String = .empty
    @Persisted var likesCount: Int = .zero
    @Persisted var postedOn: Date = Date()
    @Persisted var createdAt: Date = Date()
    @Persisted var userPost: UserModel?
    @Persisted var actions = List<ActionModel>()
    @Persisted var commets = List<CommentModel>()
    @Persisted var isLiked: Bool = false
    @Persisted var isSaved: Bool = false
    
    convenience init(with post: Post) {
        self.init()
        id = post.id
        postDescription = post.description
        image = post.image
        likesCount = post.likesCount
        postedOn = post.postedOn
        createdAt = post.createdAt
        userPost = UserModel(with: post.from)
        actions.append(objectsIn: post.actions.map({
            ActionModel(with: $0)
        }))
        commets.append(objectsIn: post.comments.map({
            CommentModel(with: $0)
        }))
    }
}

class CommentModel: Object {
    @Persisted(primaryKey: true) var id: Int = .zero
    @Persisted var commentDescription: String = .empty
    @Persisted var likesCount: Int = .zero
    @Persisted var user: UserModel?
    @Persisted var postedOn: Date = Date()
    @Persisted var isLiked: Bool = false
    
    convenience init(with comment: Comment) {
        self.init()
        id = comment.id
        commentDescription = comment.description
        likesCount = comment.likesCount
        user = UserModel(with: comment.from)
    }
    
    convenience init(with commentDTO: CommentDTO) {
        self.init()
        id = commentDTO.id
        commentDescription = commentDTO.description
        likesCount = commentDTO.likesCount
        user = UserModel(with: commentDTO.user)
    }
}

class ActionModel: Object {
    @Persisted(primaryKey: true) var name: String = .empty
    
    convenience init(with action: Action) {
        self.init()
        name = action.name.rawValue
    }
    
    convenience init(action: String) {
        self.init()
        name = action
    }
}

class UserModel: Object {
    @Persisted(primaryKey: true) var id: Int = .zero
    @Persisted var userName: String = .empty
    @Persisted var userImageUrl: String = .empty
    
    convenience init(with userPost: User) {
        self.init()
        id = userPost.id
        userName = userPost.userName
        userImageUrl = userPost.userImageURL
    }
    
    convenience init(with userDTO: UserDTO) {
        self.init()
        id = userDTO.id
        userName = userDTO.userName
        userImageUrl = userDTO.userImageURL
    }
    
    convenience init(_ emptyId: Int = .zero) {
        self.init()
        id = .zero
        userName = .empty
        userImageUrl = .empty
    }
}
