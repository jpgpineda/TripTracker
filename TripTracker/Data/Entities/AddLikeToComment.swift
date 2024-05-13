//
//  AddLikeToComment.swift
//  TripTracker
//
//  Created by javier pineda on 13/05/24.
//

import Foundation

struct AddLikeToComment: Codable {
    let postId: Int
    let commentId: Int
    let from: User
}
