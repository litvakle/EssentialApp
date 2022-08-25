//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Lev Litvak on 25.08.2022.
//  Copyright © 2022 Essential Developer. All rights reserved.
//

import Foundation
import EssentialFeed

public final class FeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader
    private let cache: FeedCache
    
    public init(decoratee: FeedLoader, cache: FeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            if case let .success(feed) = result {
                self?.cache.save(feed, completion: { _ in })
            }
            completion(result)
        }
    }
}
