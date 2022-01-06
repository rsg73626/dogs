//
//  BreedsViewModel.swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import Foundation

final class BreedsViewModel {

    private let service: BreedsService
    private let breedService: BreedService
    private let availabledWidth: Float
    static var listLayout = "rectangle.grid.1x2"
    static var listLayoutFilled = "rectangle.grid.1x2.fill"
    static var gridLayout = "square.grid.2x2"
    static var gridLayoutFilled = "square.grid.2x2.fill"
    private static var title: String = ""
    private static var errorMessage: String = ""
    private static var emptyMessage: String = ""
    private static var loadingMessage: String = ""
    private static var tryAgainButtonTitle: String = ""
    private var paging = false
    private var didEndPaging = false
    private var currentPage: Int = 0

    let layoutSwitcherButtons = Box((list: Image.system(name: ""), grid: Image.system(name: "")))
    let title = Box("")
    let isLoading = Box(true)
    let isPaging = Box(true)
    let message = Box("")
    let retry = Box((title: "", visible: false))
    let breeds = Box([BreedViewModel]())
    let hideList = Box(true)
    let hideGrid = Box(true)

    init(service: BreedsService,
         breedService: BreedService,
         availabledWidth: Float,
         title: String,
         errorMessage: String,
         emptyMessage: String,
         loadingMessage: String,
         tryAgainButtonTitle: String) {
        self.service = service
        self.breedService = breedService
        self.availabledWidth = availabledWidth
        BreedsViewModel.title = title
        BreedsViewModel.errorMessage = errorMessage
        BreedsViewModel.emptyMessage = emptyMessage
        BreedsViewModel.loadingMessage = loadingMessage
        BreedsViewModel.tryAgainButtonTitle = tryAgainButtonTitle
    }

    func bootstrap() {
        layoutSwitcherButtons.value = (.system(name: BreedsViewModel.listLayout), .system(name: BreedsViewModel.gridLayout))
        title.value = BreedsViewModel.title
        isLoading.value = true
        message.value = BreedsViewModel.loadingMessage
        retry.value = (BreedsViewModel.tryAgainButtonTitle, false)
        service.loadBreeds(page: currentPage) { [weak self] breeds in
            guard let self = self else { return }
            self.isLoading.value = false
            if let breeds = breeds {
                self.didGet(breeds)
            } else {
                self.message.value = BreedsViewModel.errorMessage
                self.retry.value = (BreedsViewModel.tryAgainButtonTitle, true)
            }
        }
    }

    func didSelectBreed(at index: Int) {

    }

    func willShowBreed(at index: Int) {
        if breeds.value.isEmpty == false, index == breeds.value.count - 1 {
            getNextPage()
        }
    }
    
    func didSelectListLayout() {
        layoutSwitcherButtons.value = (.system(name: BreedsViewModel.listLayoutFilled), .system(name: BreedsViewModel.gridLayout))
    }
    
    func didSelectGridLayout() {
        layoutSwitcherButtons.value = (.system(name: BreedsViewModel.listLayout), .system(name: BreedsViewModel.gridLayoutFilled))
    }
    
    private func getNextPage() {
        guard paging == false, didEndPaging == false else { return }
        isPaging.value = true
        service.loadBreeds(page: currentPage) { [weak self] breeds in
            self?.paging = false
            self?.isPaging.value = false
            if let breeds = breeds {
                if breeds.isEmpty {
                    self?.didEndPaging = true
                } else {
                    self?.didGetPage(breeds)
                }
            }
        }
    }
    
    private func didGetPage(_ breeds: [Breed]) {
        currentPage += 1
        self.breeds.value = self.breeds.value + breeds.toViewModel(self.breedService, availabledWidth: self.availabledWidth)
    }
    
    private func didGet(_ breeds: [Breed]) {
        if breeds.isEmpty {
            message.value = BreedsViewModel.emptyMessage
        } else {
            currentPage += 1
            message.value = ""
            self.breeds.value = self.breeds.value + breeds.toViewModel(self.breedService, availabledWidth: self.availabledWidth)
            hideList.value = false
        }
    }

}

private extension Array where Element == Breed {

    func toViewModel(_ service: BreedService, availabledWidth: Float) -> [BreedViewModel] {
        map { BreedViewModel(breed: $0, service: service, availableWidth: availabledWidth) }
    }
}
