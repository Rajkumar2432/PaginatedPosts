//
//  PostViewModelTests.swift
//  PaginatedPostsTests
//
//  Created by Rajkumar Gurunathan on 30/05/24.
//

import XCTest
import Combine
@testable import PaginatedPosts

class PostViewModelTests: XCTestCase {
    var viewModel: PostViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = PostViewModel(postService: MockPostService())
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchPosts() {
        let expectation = self.expectation(description: "Fetching posts")
        
        viewModel.$posts
            .dropFirst()
            .sink { posts in
                XCTAssertEqual(posts.count, 10, "Expected 10 posts")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchPosts()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

// Mock Post Service for testing
class MockPostService: PostServiceProtocol {
    func fetchPosts(page: Int, limit: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        let mockPosts = (1...limit).map { id in
            Post(userId: 1, id: id, title: "Title \(id)", body: "Body \(id)")
        }
        completion(.success(mockPosts))
    }
}
