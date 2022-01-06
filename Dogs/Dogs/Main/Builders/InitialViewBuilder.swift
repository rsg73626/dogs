//
//  InitialViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import UIKit

struct InitialViewBuilder {

    private init() { }

    static func build(screenSize: CGSize) -> UIViewController {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")!
        let key = "971ba769-29e2-4a33-895e-9359c499444c"
        let api = TheDogAPI(httpClient: URLSessionHTTPClient(), url: url, apiKey: key)
        let service = BreedsServiceAdapter(api: api)
        let dispatcher = BreedsServiceCompletionDispatcher()
        dispatcher.composed = service
        let breedService = BreedServiceAdapter(httpClient: URLSessionHTTPClient())
        let breedServiceDispatcher = BreedServiceCompletionDispatcher()
        breedServiceDispatcher.composed = breedService
        let view = BreedsViewBuilder.build(breedsService: dispatcher, breedService: breedServiceDispatcher, availabledWidth: Float(screenSize.width))
        let nav = UINavigationController(rootViewController: view)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray6
        nav.navigationBar.standardAppearance = appearance;
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        
        return nav
    }
}
