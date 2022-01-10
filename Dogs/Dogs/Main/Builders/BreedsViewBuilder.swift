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
                                        availabledWidth: availabledWidth)
        viewModel.viewTitle = "BreedsList.title".localized
        viewModel.errorMessage = "BreedsList.errorMessage".localized
        viewModel.emptyMessage = "BreedsList.emptyMessage".localized
        viewModel.loadingMessage = "BreedsList.loadingMessage".localized
        viewModel.tryAgainButtonTitle = "BreedsList.retry".localized
        viewModel.listLayout = "rectangle.grid.1x2"
        viewModel.listLayoutFilled = "rectangle.grid.1x2.fill"
        viewModel.gridLayout = "square.grid.2x2"
        viewModel.gridLayoutFilled = "square.grid.2x2.fill"
        viewModel.sortImage = "arrow.up.arrow.down.circle"
        viewModel.sortedImage = "arrow.up.arrow.down.circle.fill"
        view.viewModel = viewModel
        router.view = view
        return view
    }
}
