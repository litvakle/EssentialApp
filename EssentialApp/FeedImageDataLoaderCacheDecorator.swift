//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Lev Litvak on 26.08.2022.
//  Copyright © 2022 Essential Developer. All rights reserved.
//

import Foundation
import EssentialFeed

public class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    
    public init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] result in
            if case let .success(data) = result {
                self?.cache.save(data, for: url) { _ in }
            }
                
            completion(result)
        }
    }
}
