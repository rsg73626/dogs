//
//  swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

final class SearchViewModel {
    
    var viewTitle: String = ""
    var errorMessage: String = ""
    var emptyMessage: String = ""
    var loadingMessage: String = ""
    var tryAgainButtonTitle: String = ""
    var listLayout = ""
    var listLayoutFilled = ""
    var gridLayout = ""
    var gridLayoutFilled = ""
    var sortImage = ""
    var sortedImage = ""
    
    private let service: SearchService
    private let breedService: BreedService
    private let availabledWidth: Float
    private let router: BreedsWireframe
    private var paging = false
    private var didEndPaging = false
    private var currentPage: Int = 0
    private var sorted = false
    
    private var downloadedBreeds = [Breed]()
    private var currentBreeds: [Breed] {
        sorted ? downloadedBreeds.sorted { $0.name < $1.name } : downloadedBreeds
    }
    private var currentSortButtonImage: Image {
        .system(name: sorted ? sortedImage : sortImage)
    }

    let layoutSwitcherButtons = Box((list: Image.system(name: ""), grid: Image.system(name: "")))
    let sortButton = Box(Image.system(name: ""))
    let title = Box("")
    let isLoading = Box(true)
    let isPaging = Box(true)
    let message = Box("")
    let retry = Box((title: "", visible: false))
    let breeds = Box([BreedViewModel]())
    let hideList = Box(true)
    let hideGrid = Box(true)

    init(service: SearchService,
         breedService: BreedService,
         router: BreedsWireframe,
         availabledWidth: Float) {
        self.service = service
        self.breedService = breedService
        self.router = router
        self.availabledWidth = availabledWidth
    }

    func bootstrap() {
        layoutSwitcherButtons.value = (.system(name: listLayoutFilled), .system(name: gridLayout))
        sortButton.value = currentSortButtonImage
        title.value = viewTitle
        isLoading.value = true
        message.value = loadingMessage
        retry.value = (tryAgainButtonTitle, false)
//        service.loadBreeds(page: currentPage) { [weak self] breeds in
//            guard let self = self else { return }
//            self.isLoading.value = false
//            if let breeds = breeds {
//                self.didGet(breeds)
//            } else {
//                self.message.value = errorMessage
//                self.retry.value = (tryAgainButtonTitle, true)
//            }
//        }
    }

    func didSelectBreed(at index: Int) {
        router.showBreedDetails(downloadedBreeds[index])
    }

    func willShowBreed(at index: Int) {
        if downloadedBreeds.isEmpty == false, index == downloadedBreeds.count - 1 {
            getNextPage()
        }
    }
    
    func didSelectListLayout() {
        layoutSwitcherButtons.value = (.system(name: listLayoutFilled), .system(name: gridLayout))
        hideGrid.value = true
        hideList.value = false
    }
    
    func didSelectGridLayout() {
        layoutSwitcherButtons.value = (.system(name: listLayout), .system(name: gridLayoutFilled))
        hideList.value = true
        hideGrid.value = false
    }
    
    func didPressSort() {
        sorted = not(sorted)
        breeds.value = currentBreeds.toViewModel(breedService, availabledWidth: availabledWidth)
        sortButton.value = currentSortButtonImage
    }
    
    private func getNextPage() {
        guard paging == false, didEndPaging == false else { return }
        isPaging.value = true
//        service.loadBreeds(page: currentPage) { [weak self] breeds in
//            self?.paging = false
//            self?.isPaging.value = false
//            if let breeds = breeds {
//                if breeds.isEmpty {
//                    self?.didEndPaging = true
//                } else {
//                    self?.didGetPage(breeds)
//                }
//            }
//        }
    }
    
    private func didGetPage(_ breeds: [Breed]) {
        currentPage += 1
        downloadedBreeds = downloadedBreeds + breeds
        self.breeds.value = currentBreeds.toViewModel(breedService, availabledWidth: availabledWidth)
    }
    
    private func didGet(_ breeds: [Breed]) {
        if breeds.isEmpty {
            message.value = emptyMessage
        } else {
            currentPage += 1
            message.value = ""
            downloadedBreeds = breeds
            self.breeds.value = currentBreeds.toViewModel(breedService, availabledWidth: availabledWidth)
            hideList.value = false
        }
    }
    
}
