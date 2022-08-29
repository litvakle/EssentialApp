//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Combine
import Foundation
import EssentialFeed
import EssentialFeediOS

final class FeedImageDataLoaderPresentationAdapter<View: FeedImageView, Image>: FeedImageCellControllerDelegate where View.Image == Image {
	private let model: FeedImage
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
	
	var presenter: FeedImagePresenter<View, Image>?
    private var cancellable: Cancellable?
    
	init(model: FeedImage, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) {
		self.model = model
		self.imageLoader = imageLoader
	}
	
	func didRequestImage() {
		presenter?.didStartLoadingImageData(for: model)
		
		let model = self.model
		
        cancellable = imageLoader(model.url).sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case let .failure(error):
                self?.presenter?.didFinishLoadingImageData(with: error, for: model)
            }
        } receiveValue: { [weak self] data in
            self?.presenter?.didFinishLoadingImageData(with: data, for: model)
        }
	}
	
	func didCancelImageRequest() {
		cancellable?.cancel()
	}
}
