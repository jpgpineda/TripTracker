//
//  MakeComment.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

struct MakeComment: Codable {
    let postId: Int
    let description: String
    let from: User
}
