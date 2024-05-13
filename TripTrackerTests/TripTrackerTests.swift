//
//  TripTrackerTests.swift
//  TripTrackerTests
//
//  Created by javier pineda on 13/05/24.
//

import XCTest
@testable import TripTracker

final class TripTrackerTests: TripTrackerBaseTest {
    
    func testPostResponseNotEmpty() async {
        // Arrange
        let apiGateway = PostApiGatewayImplementation(apiClient: apiClient,
                                                      storageContext: storageContext)
        
        let useCase = PostUseCaseImplementation(apiGateway: apiGateway)
        
        // ACt
        let result = await useCase.fetchPosts(parameters: FetchPostsRequest())
        
        // Assert
        switch result {
        case .success(let posts):
            XCTAssertFalse(posts.isEmpty)
        case .failure(let apiError):
            XCTFail("The test has failed: \(apiError.customDescription)")
        }
    }
    
    func testPostActionsNotEmpty() async {
        // Arrange
        let apiGateway = PostApiGatewayImplementation(apiClient: apiClient,
                                                      storageContext: storageContext)
        
        let useCase = PostUseCaseImplementation(apiGateway: apiGateway)
        
        // Act
        let result = await useCase.fetchPosts(parameters: FetchPostsRequest())
        
        // Assert
        switch result {
        case .success(let posts):
            guard let post = posts.first else {
                XCTFail("The test has failed due to empty data")
                return
            }
            XCTAssertFalse(post.actions.isEmpty)
        case .failure(let apiError):
            XCTFail("The test has failed: \(apiError.customDescription)")
        }
    }
    
    func testCommentsNotEmpty() async {
        // Arrange
        let apiGateway = PostApiGatewayImplementation(apiClient: apiClient,
                                                      storageContext: storageContext)
        
        let useCase = PostUseCaseImplementation(apiGateway: apiGateway)
        
        // Act
        let result = await useCase.fetchPosts(parameters: FetchPostsRequest())
        
        // Assert
        switch result {
        case .success(let posts):
            guard let post = posts.first else {
                XCTFail("The test has failed due to empty data")
                return
            }
            XCTAssertFalse(post.commets.isEmpty)
        case .failure(let apiError):
            XCTFail("The test has failed: \(apiError.customDescription)")
        }
    }
}
