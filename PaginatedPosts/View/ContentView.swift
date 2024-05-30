//
//  ContentView.swift
//  PaginatedPosts
//
//  Created by Rajkumar Gurunathan on 30/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var showDetailView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts.indices, id: \.self) { index in
                    let post = viewModel.posts[index]
                    PostRow(post: post) {
                        onTapRow(post, index)
                    }
                    .onAppear {
                        onAppearRow(index)
                    }
                }
            }
            .navigationTitle("Posts")
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                    } else {
                        EmptyView()
                    }
                }
            )
            .background(
                NavigationLink(
                    destination: viewModel.selectedPost.map { post in
                        PostDetailView(post: post)
                            .onAppear {
                             //   onAppearDetailView(post)
                            }
                    },
                    isActive: $showDetailView
                ) {
                    EmptyView()
                }
            )
        }
    }
    
    private func onTapRow(_ post: Post, _ index: Int) {
        if index % 2 == 0 {
            viewModel.performUnoptimizedComputation(on: post) { computedPost in
                viewModel.selectedPost = computedPost
                showDetailView = true
            }
        } else {
            viewModel.performOptimizedComputation(on: post) { computedPost in
                viewModel.selectedPost = computedPost
                showDetailView = true
            }
        }
    }
    
    private func onAppearRow(_ index: Int) {
        if index == viewModel.posts.count - 1 {
            viewModel.fetchPosts()
        }
    }
    
//    private func onAppearDetailView(_ post: Post) {
//        if viewModel.selectedPostIndex % 2 == 0 {
//            viewModel.performUnoptimizedComputation(on: post) { _ in }
//        } else {
//            viewModel.performOptimizedComputation(on: post) { _ in }
//        }
//    }
}



#Preview {
    ContentView()
}
