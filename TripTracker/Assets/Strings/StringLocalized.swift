//
//  StringLocalized.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import Foundation

extension String {
    struct Localized {
        // MARK: API errors
        static var invalidResponse: String { return getLocalizedString(#function) }
        static var statusCode: String { return getLocalizedString(#function) }
        static var requestFailed: String { return getLocalizedString(#function) }
        static var invalidData: String { return getLocalizedString(#function) }
        static var JSONConversionFailure: String { return getLocalizedString(#function) }
        static var serializationFailed: String { return getLocalizedString(#function) }
        static var JSONParsingFailure: String { return getLocalizedString(#function) }
        static var noInternet: String { return getLocalizedString(#function) }
        static var unsuccessfull: String { return getLocalizedString(#function) }
        static var noActiveSession: String { return getLocalizedString(#function) }
        static var unexpected: String { return getLocalizedString(#function) }
        static var ups: String { return getLocalizedString(#function) }
        
        // MARK: Posts
        static var comments: String { return getLocalizedString(#function) }
        static var postedOn: String { return getLocalizedString(#function) }
        
        internal static func getLocalizedString(_ key: String) -> String {
            return NSLocalizedString(key, comment: key)
        }
    }
}
