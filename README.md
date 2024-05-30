# Posts App

## Overview

This iOS application displays a list of posts fetched from a network service. Each list item requires intensive computation to display additional details, for which both unoptimized and optimized algorithms are implemented. Caching mechanisms are employed to prevent unnecessary re-computation and re-rendering, enhancing the performance and user experience.

## Features

- Fetches and displays a list of posts.
- Performs heavy computations to generate additional details for each post.
- Implements both unoptimized and optimized algorithms for these computations.
- Logs the time taken for both unoptimized and optimized computations.

## Requirements

- Xcode 12 or later
- iOS 14.0 or later
- Swift 5.3 or later

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/PostsApp.git
   cd PostsApp
   ```
2. Open the project in Xcode:
   ```sh
   open PostsApp.xcodeproj
   ```

3. Build and run the project on a simulator or device.

## Usage

When the app is launched, it fetches posts from a network service and displays them in a list. Each list item can be tapped to perform a heavy computation to generate additional details:

- If the item's index is even, it performs unoptimized computation.
- If the item's index is odd, it performs optimized computation.

### Logging Computation Time

The app logs the time taken for each computation in the console. This helps in comparing the performance of the unoptimized and optimized algorithms.

## Code Structure

### Models

- `Post`: Represents a post fetched from the network service.

### ViewModels

- `PostViewModel`: Manages the state and business logic for fetching posts and handling computations.

### Services

- `PostService`: Protocol defining the methods for fetching posts.
- `PostServiceImplementation`: Concrete implementation of `PostService`.
- `HeavyComputationService`: Performs heavy computations, with both unoptimized and optimized methods, and employs caching.

### Views

- `ContentView`: Main view displaying the list of posts and handling navigation.
- `PostDetailView`: Displays the details of a selected post.

## Implementation Details

### Heavy Computation Service

The `HeavyComputationService` is responsible for performing intensive computations. It includes methods for both unoptimized and optimized computations:

- `unoptimizedComputation(on:completion:)`: Performs matrix multiplication in a single-threaded manner.
- `optimizedComputation(on:completion:)`: Uses parallel processing to speed up matrix multiplication.

### Logging

The time taken for both unoptimized and optimized computations is logged in the console for performance comparison.

