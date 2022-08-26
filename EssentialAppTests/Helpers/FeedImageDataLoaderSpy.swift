//
//  FeedImageDataLoaderSpy.swift
//  EssentialAppTests
//
//  Created by Lev Litvak on 26.08.2022.
//  Copyright © 2022 Essential Developer. All rights reserved.
//

import Foundation
import EssentialFeed

class FeedImageDataLoaderSpy: FeedImageDataLoader {
    private var messages = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
    
    var loadedURLs: [URL] {
        return messages.map { $0.url }
    }
    
    var cancelledURLs = [URL]()
    
    private struct Task: FeedImageDataLoaderTask {
        var callback: () -> Void
        
        func cancel() {
            callback()
        }
    }
    
    func completeSuccesfully(with data: Data, at index: Int = 0) {
        messages[index].completion(.success(data))
    }
    
    func complete(withError error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        messages.append((url, completion))
        return Task { [weak self] in
            self?.cancelledURLs.append(url)
        }
    }
}
