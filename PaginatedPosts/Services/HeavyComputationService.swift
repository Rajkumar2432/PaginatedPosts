//
//  HeavyComputationService.swift
//  PaginatedPosts
//
//  Created by Rajkumar Gurunathan on 30/05/24.
//

import Foundation

class HeavyComputationService {
    func unoptimizedComputation(on post: Post, completion: @escaping (Post) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let resultPost = self.performUnoptimizedHeavyComputation(on: post)
            DispatchQueue.main.async {
                completion(resultPost)
            }
        }
    }
    
    func optimizedComputation(on post: Post, completion: @escaping (Post) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let resultPost = self.performOptimizedHeavyComputation(on: post)
            DispatchQueue.main.async {
                completion(resultPost)
            }
        }
    }
    
    private func performUnoptimizedHeavyComputation(on post: Post) -> Post {
        let matrixSize = 500
        let matrixA = generateRandomMatrix(size: matrixSize)
        let matrixB = generateRandomMatrix(size: matrixSize)
        let resultMatrix = matrixMultiplication(matrixA: matrixA, matrixB: matrixB)
        
        let computedPost = Post(userId: post.userId, id: post.id, title: "\(post.title) - \(resultMatrix)", body: post.body)
        
        return computedPost
    }
    
    private func performOptimizedHeavyComputation(on post: Post) -> Post {
        let matrixSize = 500
        let matrixA = generateRandomMatrix(size: matrixSize)
        let matrixB = generateRandomMatrix(size: matrixSize)
        let resultMatrix = parallelMatrixMultiplication(matrixA: matrixA, matrixB: matrixB)
        
        // Create a new post with additional computed data
        let computedPost = Post(userId: post.userId, id: post.id, title: "\(post.title) - \(resultMatrix)", body: post.body)
        
        return computedPost
    }
    
    private func generateRandomMatrix(size: Int) -> [[Double]] {
        var matrix = [[Double]]()
        for _ in 0..<size {
            var row = [Double]()
            for _ in 0..<size {
                row.append(Double.random(in: 0..<10))
            }
            matrix.append(row)
        }
        return matrix
    }
    
    private func matrixMultiplication(matrixA: [[Double]], matrixB: [[Double]]) -> [[Double]] {
        let rowsA = matrixA.count
        let colsA = matrixA[0].count
        let colsB = matrixB[0].count
        
        var result = Array(repeating: Array(repeating: 0.0, count: colsB), count: rowsA)
        
        for i in 0..<rowsA {
            for j in 0..<colsB {
                for k in 0..<colsA {
                    result[i][j] += matrixA[i][k] * matrixB[k][j]
                }
            }
        }
        
        return result
    }
    
    private func parallelMatrixMultiplication(matrixA: [[Double]], matrixB: [[Double]]) -> [[Double]] {
        let rowsA = matrixA.count
        let colsA = matrixA[0].count
        let colsB = matrixB[0].count
        
        var result = Array(repeating: Array(repeating: 0.0, count: colsB), count: rowsA)
        
        DispatchQueue.concurrentPerform(iterations: rowsA) { i in
            for j in 0..<colsB {
                for k in 0..<colsA {
                    result[i][j] += matrixA[i][k] * matrixB[k][j]
                }
            }
        }
        
        return result
    }
}

