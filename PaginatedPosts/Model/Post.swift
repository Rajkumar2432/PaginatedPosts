//
//  Post.swift
//  PaginatedPosts
//
//  Created by Rajkumar Gurunathan on 30/05/24.
//

import Foundation

struct Post: Identifiable, Codable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    // Conformance to Equatable
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
