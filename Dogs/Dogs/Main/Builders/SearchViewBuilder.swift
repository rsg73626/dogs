//
//  SearchViewBuilder.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

struct SearchViewBuilder {
    
    private init() { }
    
    static func build(searchService: SearchService, imageService: ImageService, availabledWidth: Float) -> SearchView {
        let view = SearchView()
        let router = BreedsRouter()
        let viewModel = SearchViewModel(service: searchService,
                                        imageService: imageService,
                                        router: router,
                                        availabledWidth: availabledWidth)
        viewModel.viewTitle = "BreedsList.title".localized
        viewModel.searchBarPlaceholder = "Search.placeholder".localized
        viewModel.errorMessage = "BreedsList.errorMessage".localized
        viewModel.emptyMessage = "BreedsList.emptyMessage".localized
        viewModel.loadingMessage = "BreedsList.loadingMessage".localized
        viewModel.enterSomeTextMessage = "BreedsList.enterTextMessage".localized
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
