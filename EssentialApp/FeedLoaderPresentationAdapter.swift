//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import EssentialFeed
import EssentialFeediOS
import Combine

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    private let feedLoader: () -> AnyPublisher<[FeedImage], Error>
	var presenter: FeedPresenter?
    private var cancellable: Cancellable?
    
	init(feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>) {
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
