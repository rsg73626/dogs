//
//  BreedsViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation
import UIKit

struct BreedsViewBuilder {
    
    private init() { }
    
    static func build(breedsService: BreedsService, breedService: BreedService, availabledWidth: Float) -> BreedsView {
        let view = BreedsView()
        let router = BreedsRouter()
        let viewModel = BreedsViewModel(service: breedsService,
                                        breedService: breedService,
                                        router: router,
                                        availabledWidth: availabledWidth,
                                        title: "BreedsList.title".localized,
                                        errorMessage: "BreedsList.errorMessage".localized,
                                        emptyMessage: "BreedsList.emptyMessage".localized,
                                        loadingMessage: "BreedsList.loadingMessage".localized,
                                        tryAgainButtonTitle: "BreedsList.retry".localized)
        view.viewModel = viewModel
        router.view = view
        return view
    }
}
