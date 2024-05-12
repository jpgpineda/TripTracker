//
//  FavoritePostModel.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation
import RealmSwift

class FavoritePostModel: Object {
    @Persisted(primaryKey: true) var id: Int = .zero
    @Persisted var postDescription: String = .empty
    @Persisted var image: String = .empty
    @Persisted var likesCount: Int = .zero
    @Persisted var postedOn: Date = Date()
    @Persisted var userPost: UserModel
    @Persisted var actions = List<ActionModel>()
    @Persisted var commets = List<CommentModel>()
    @Persisted var isLiked: Bool = false
    
    convenience init(with postDTO: PostDTO) {
        self.init()
        id = postDTO.id
        postDescription = postDTO.description
        image = postDTO.image
        likesCount = postDTO.likesCount
        postedOn = postDTO.postedOn
        userPost = UserModel(with: postDTO.user)
        actions.append(objectsIn: postDTO.actions.compactMap({
            ActionModel(action: $0)
        }))
        commets.append(objectsIn: postDTO.commets.compactMap({
            CommentModel(with: $0)
        }))
    }
}
