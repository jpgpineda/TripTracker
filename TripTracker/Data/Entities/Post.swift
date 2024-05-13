//
//  Post.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

struct PostResponse: Codable {
    let data: [Post]
}

// MARK: - Datum
struct Post: Codable {
    let description: String
    let image: String
    let likesCount, id: Int
    let from: User
    let actions: [Action]
    let comments: [Comment]?
    let postedOn: Date
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case description, image
        case likesCount = "likes_count"
        case id, from, actions, comments
        case postedOn = "posted_on"
        case createdAt = "created_at"
    }
}

struct Comment: Codable {
    let id: Int
    let description: String
    let likesCount: Int
    let from: User
    let postedOn: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case likesCount = "likes_count"
        case from
        case postedOn = "posted_on"
    }
}

struct Action: Codable {
    let name: ActionTitle
}

enum ActionTitle: String, Codable {
    case comment = "comment"
    case share = "share"
}

struct User: Codable {
    let id: Int
    let userName: String
    let userImageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "user_name"
        case userImageURL = "user_image_url"
    }
    
    init(from userDTO: UserDTO) {
        id = userDTO.id
        userName = userDTO.userName
        userImageURL = userDTO.userImageURL
    }
}
