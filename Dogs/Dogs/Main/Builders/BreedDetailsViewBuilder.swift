//
//  BreedDetailsViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

struct BreedDetailsViewBuilder {
    
    private init() { }
    
    static func build(model: Model) -> BreedDetailsView {
        let view = BreedDetailsView()
        let adapter = ImageServiceAdapter(httpClient: URLSessionHTTPClient())
        let dispatcher = ImageServiceCompletionDispatcher()
        let viewModel = BreedDetailsViewModel(model: model, imageService: dispatcher)
        
        view.viewModel = viewModel
        dispatcher.composed = adapter
        
        return view
    }
    
}
