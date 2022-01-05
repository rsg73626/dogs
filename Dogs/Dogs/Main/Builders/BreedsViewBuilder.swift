//
//  BreedsViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

struct BreedsViewBuilder {
    
    private init() { }
    
    static func build(breedsService: BreedsService, breedService: BreedService) -> BreedsView {
        let view = BreedsView()
        let viewModel = BreedsViewModel(service: breedsService,
                                        breedService: breedService,
                                        errorMessage: "BreedsList.errorMessage".localized,
                                        emptyMessage: "BreedsList.emptyMessage".localized,
                                        loadingMessage: "BreedsList.loadingMessage".localized)
        view.viewModel = viewModel
        return view
    }
}
