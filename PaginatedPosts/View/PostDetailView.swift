//
//  PostDetailView.swift
//  PaginatedPosts
//
//  Created by Rajkumar Gurunathan on 30/05/24.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            } else {
                Text("Title: \(post.title)")
                Text("Body: \(post.body)")
            }
        }
        .padding()
    }
}
