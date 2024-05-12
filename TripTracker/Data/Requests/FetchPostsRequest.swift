//
//  FetchPostsRequest.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

struct FetchPostsRequest: ApiRequest {
    var stringUrl: String {
        return Host.mainMock + ""
    }
    
    var apiRequest: URLRequest? {
        guard let url = URL(string: stringUrl) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET
        return request
    }
}
