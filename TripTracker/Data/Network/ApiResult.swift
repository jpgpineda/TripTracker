//
//  ApiResult.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import Foundation

enum ApiResult<T> {
    case success(T)
    case failure(ApiError)
    
    func dematerialize() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            return error as! T
        }
    }
}
