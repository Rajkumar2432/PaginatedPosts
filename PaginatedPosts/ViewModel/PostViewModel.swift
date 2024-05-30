//
//  PostViewModel.swift
//  PaginatedPosts
//
//  Created by Rajkumar Gurunathan on 30/05/24.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var selectedPost: Post?
    
    private var page = 1
    private let limit = 10
    private let postService: PostServiceProtocol
    private let heavyComputationService: HeavyComputationService
    private var cancellables = Set<AnyCancellable>()
    
    init(postService: PostServiceProtocol = PostService(), heavyComputationService: HeavyComputationService = HeavyComputationService()) {
        self.postService = postService
        self.heavyComputationService = heavyComputationService
        fetchPosts()
    }
    
    func fetchPosts() {
        guard !isLoading else { return }
        
        isLoading = true
        postService.fetchPosts(page: page, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let posts):
                    self?.posts.append(contentsOf: posts)
                    self?.page += 1
                case .failure(let error):
                    print("Failed to fetch posts: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func performUnoptimizedComputation(on post: Post, completion: @escaping (Post) -> Void) {
        isLoading = true
        let startTime = Date()
        heavyComputationService.unoptimizedComputation(on: post) { [weak self] computedPost in
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            print("Unoptimized computation took \(timeInterval) seconds")
            DispatchQueue.main.async {
                self?.isLoading = false
                completion(computedPost)
            }
        }
    }
    
    func performOptimizedComputation(on post: Post, completion: @escaping (Post) -> Void) {
        isLoading = true
        let startTime = Date()
        heavyComputationService.optimizedComputation(on: post) { [weak self] computedPost in
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            print("Optimized computation took \(timeInterval) seconds")
            DispatchQueue.main.async {
                self?.isLoading = false
                completion(computedPost)
            }
        }
    }
}
