//
//  ApiError.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import Foundation

enum ApiError: Error {
    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case sessionNotActive
    case unknown
    case noInternet
    
    var customDescription: String {
        switch self {
        case let .requestFailed(description): return .Localized.requestFailed + description
        case .invalidData: return .Localized.invalidData
        case let .responseUnsuccessful(description): return .Localized.unsuccessfull + description
        case let .jsonConversionFailure(description): return .Localized.JSONConversionFailure + description
        case .jsonParsingFailure: return .Localized.JSONParsingFailure
        case .failedSerialization: return .Localized.serializationFailed
        case .sessionNotActive: return .Localized.noActiveSession
        case .unknown: return .Localized.unexpected
        case .noInternet: return .Localized.noInternet
        }
    }
}
