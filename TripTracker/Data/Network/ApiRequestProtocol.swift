//
//  ApiRequestProtocol.swift
//  TripTracker
//
//  Created by javier pineda on 11/05/24.
//

import Foundation

protocol ApiRequest {
    var apiRequest: URLRequest? { get }
}
