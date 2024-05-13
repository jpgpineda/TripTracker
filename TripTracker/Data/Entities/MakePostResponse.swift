//
//  MakePostResponse.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

struct MakePostResponse: Codable {
    let message: String
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case message, code
    }
}
