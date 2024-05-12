//
//  ApiClient.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import Foundation

final class ApiClient: GenericApi {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}
