//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import CoreData
import EssentialFeed
import EssentialFeediOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let _ = (scene as? UIWindowScene) else { return }
		
//        let url = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!
//
//        let session = URLSession(configuration: .ephemeral)
//        let client = URLSessionHTTPClient(session: session)
//        let remoteFeedLoader = RemoteFeedLoader(url: url, client: client)
//        let RemoteImageLoader = RemoteFeedImageDataLoader(client: client)
//
//        let localStoreURL = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("feed-store.sqlite")
//        let localStore = try! CoreDataFeedStore(storeURL: localStoreURL)
//        let localFeedLoader = LocalFeedLoader(store: localStore, currentDate: Date.init)
//        let localImageLoader = LocalFeedImageDataLoader(store: localStore)
//
//        window?.rootViewController = FeedUIComposer.feedComposedWith(
//            feedLoader: FeedLoaderWithFallbackComposite(
//                primary: FeedLoaderCacheDecorator(
//                    decoratee: remoteFeedLoader,
//                    cache: localFeedLoader),
//                fallback: localFeedLoader),
//            imageLoader: FeedImageDataLoaderWithFallbackComposite(
//                primary: localImageLoader,
//                fallback: FeedImageDataLoaderCacheDecorator(
//                    decoratee: RemoteImageLoader,
//                    cache: localImageLoader)))
	}
}
