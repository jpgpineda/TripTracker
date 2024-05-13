//
//  AddNewCommentRequest.swift
//  TripTracker
//
//  Created by javier pineda on 13/05/24.
//

import Foundation

struct AddNewCommentRequest: ApiRequest {
    let parameters: MakeComment
    
    var stringUrl: String {
        return Host.mainMock + "1951f9ac-a15d-4151-b381-4f46a1f1d5f5"
    }
    
    var apiRequest: URLRequest? {
        guard let url = URL(string: stringUrl) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET
        // This line is commented due the mock tool does not support body structure in the request
        //request.httpBody = try? JSONEncoder().encode(parameters)
        return request
    }
}
