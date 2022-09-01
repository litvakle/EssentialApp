//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import EssentialFeed
import EssentialFeediOS
import Combine

final class LoadResourcePresentationAdapter<Resource, View: ResourceView> {
    private let loader: () -> AnyPublisher<Resource, Error>
	var presenter: LoadResourcePresenter<Resource, View>?
    private var cancellable: Cancellable?
    
	init(loader: @escaping () -> AnyPublisher<Resource, Error>) {
		self.loader = loader
	}
	
	func loadResource() {
		presenter?.didStartLoading()
		
        cancellable = loader().sink { [weak self] completion in
            switch completion {
            case let .failure(error):
                self?.presenter?.didFinishLoading(with: error)
            case .finished:
                break
            }
        } receiveValue: { [weak self] resource in
            self?.presenter?.didFinishLoading(with: resource)
        }
	}
}

extension LoadResourcePresentationAdapter: FeedViewControllerDelegate {
    func didRequestFeedRefresh() {
        loadResource()
    }
}
