//
//  BreedsViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

struct BreedsViewBuilder {
    
    private init() { }
    
    static func build(service: BreedsService) -> BreedsView {
        let view = BreedsView()
        let viewModel = BreedsViewModel(service: service,
                                        errorMessage: "BreedsList.errorMessage".localized,
                                        emptyMessage: "BreedsList.emptyMessage".localized)
        view.viewModel = viewModel
        return view
    }
}
