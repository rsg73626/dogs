//
//  BreedDetailsViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

struct BreedDetailsViewBuilder {
    
    private init() { }
    
    static func build(breed: Breed) -> BreedDetailsView {
        let view = BreedDetailsView()
        let adapter = ImageServiceAdapter(httpClient: URLSessionHTTPClient())
        let dispatcher = ImageServiceCompletionDispatcher()
        let viewModel = BreedDetailsViewModel(model: breed, imageService: dispatcher)
        
        view.viewModel = viewModel
        dispatcher.composed = adapter
        
        return view
    }
    
}
