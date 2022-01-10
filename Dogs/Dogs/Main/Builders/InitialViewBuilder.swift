//
//  InitialViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import UIKit

struct InitialViewBuilder {

    private init() { }
    
    private static func breedsList(screenSize: CGSize, apiKey: String) -> BreedsView {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")!
        let api = TheDogAPI(httpClient: URLSessionHTTPClient(), url: url, apiKey: apiKey)
        let service = BreedsServiceAdapter(api: api)
        let dispatcher = BreedsServiceCompletionDispatcher()
        dispatcher.composed = service
        let imageService = ImageServiceAdapter(httpClient: URLSessionHTTPClient())
        let imageServiceDispatcher = ImageServiceCompletionDispatcher()
        imageServiceDispatcher.composed = imageService
        let view = BreedsViewBuilder.build(breedsService: dispatcher,
                                           imageService: imageServiceDispatcher,
                                           availabledWidth: Float(screenSize.width))
        view.tabBarItem = UITabBarItem(title: "List".localized, image: UIImage(systemName: "list.bullet.circle"), tag: .zero)
        return view
    }
    
    private static func breedsSearch(screenSize: CGSize, apiKey: String) -> SearchView {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds/search")!
        let api = TheDogAPI(httpClient: URLSessionHTTPClient(), url: url, apiKey: apiKey)
        let service = SearchServiceAdapter(api: api)
        let dispatcher = SearchServiceCompletionDispatcher()
        dispatcher.composed = service
        let imageService = ImageServiceAdapter(httpClient: URLSessionHTTPClient())
        let imageServiceDispatcher = ImageServiceCompletionDispatcher()
        imageServiceDispatcher.composed = imageService
        let view = SearchViewBuilder.build(searchService: dispatcher,
                                           imageService: imageServiceDispatcher,
                                           availabledWidth: Float(screenSize.width))
        view.tabBarItem = UITabBarItem(title: "Search".localized, image: UIImage(systemName: "magnifyingglass.circle"), tag: .zero)
        return view
    }
    
    private static func nav(viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        nav.navigationBar.standardAppearance = appearance;
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        return nav
    }

    static func build(screenSize: CGSize) -> UIViewController {
        let apiKey = "971ba769-29e2-4a33-895e-9359c499444c"
        let tab = UITabBarController()
        tab.viewControllers = [
            nav(viewController: breedsList(screenSize: screenSize, apiKey: apiKey)),
            nav(viewController: breedsSearch(screenSize: screenSize, apiKey: apiKey))
        ]
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        tab.tabBar.standardAppearance = appearance;
        tab.tabBar.scrollEdgeAppearance = tab.tabBar.standardAppearance
        
        return tab
    }
}
