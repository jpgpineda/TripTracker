//
//  MakePost.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

struct MakePost: Codable {
    let description: String
    let image: String
    let from: User
}
