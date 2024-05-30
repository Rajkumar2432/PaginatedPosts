//
//  PostRow.swift
//  PaginatedPosts
//
//  Created by Rajkumar Gurunathan on 30/05/24.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .font(.headline)
            Text(post.body)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .onTapGesture(perform: onTap)
    }
}
