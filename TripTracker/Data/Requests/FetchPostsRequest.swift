//
//  FetchPostsRequest.swift
//  TripTracker
//
//  Created by javier pineda on 12/05/24.
//

import Foundation

struct FetchPostsRequest: ApiRequest {
    var stringUrl: String {
        return Host.mainMock + "7e4520aa-ef33-41b2-9c4b-4fe380dbf58f"
    }
    
    var apiRequest: URLRequest? {
        guard let url = URL(string: stringUrl) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET
        return request
    }
}
