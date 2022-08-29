//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import EssentialFeed
import EssentialFeediOS
import Combine

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    private let feedLoader: () -> FeedLoader.Publisher
	var presenter: FeedPresenter?
    private var cancellable: Cancellable?
    
	init(feedLoader: @escaping () -> FeedLoader.Publisher) {
		self.feedLoader = feedLoader
	}
	
	func didRequestFeedRefresh() {
		presenter?.didStartLoadingFeed()
		
        cancellable = feedLoader().sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            case .finished:
                break
            }
        } receiveValue: { [weak self] feed in
            self?.presenter?.didFinishLoadingFeed(with: feed)
        }
	}
}
