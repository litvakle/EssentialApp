//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Combine
import UIKit
import EssentialFeed
import EssentialFeediOS

public final class FeedUIComposer {
	private init() {}
	
    private typealias PresentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>
    
    public static func feedComposedWith(feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) -> FeedViewController {
        let presentationAdapter = PresentationAdapter(
            loader: { feedLoader().dispatchOnMainQueue() })
		
		let feedController = makeFeedViewController(
			delegate: presentationAdapter,
			title: FeedPresenter.title)

		presentationAdapter.presenter = LoadResourcePresenter(
			resourceView: FeedViewAdapter(
				controller: feedController,
                imageLoader: { imageLoader($0).dispatchOnMainQueue() }),
			loadingView: WeakRefVirtualProxy(feedController),
			errorView: WeakRefVirtualProxy(feedController),
            mapper: FeedPresenter.map)
		
		return feedController
	}

	private static func makeFeedViewController(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
		let bundle = Bundle(for: FeedViewController.self)
		let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
		let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
		feedController.delegate = delegate
		feedController.title = title
		return feedController
	}
}
