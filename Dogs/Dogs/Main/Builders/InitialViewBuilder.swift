//
//  InitialViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import UIKit

struct InitialViewBuilder {

    private init() { }

    static func build() -> UIViewController {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")!
        let key = "971ba769-29e2-4a33-895e-9359c499444c"
        let api = TheDogAPI(httpClient: URLSessionHTTPClient(), url: url, apiKey: key)
        let service = BreedsServiceAdapter(api: api)
        let breedService = BreedServiceAdapter(httpClient: URLSessionHTTPClient())
        return BreedsViewBuilder.build(breedsService: service, breedService: breedService)
    }
}
