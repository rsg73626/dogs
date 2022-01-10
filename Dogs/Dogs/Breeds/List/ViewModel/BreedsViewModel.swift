//
//  swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import Foundation

final class BreedsViewModel {

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
    
    private let service: BreedsService
    private let imageService: ImageService
    private let availabledWidth: Float
    private let router: BreedsWireframe
    private var paging = false
    private var didEndPaging = false
    private var currentPage: Int = 0
    private var downloadedBreeds = [Breed]()

    let layoutSwitcherButtons = Box((list: Image.system(name: ""), grid: Image.system(name: "")))
    let title = Box("")
    let isLoading = Box(true)
    let isPaging = Box(false)
    let message = Box("")
    let retry = Box((title: "", visible: false))
    let breeds = Box([BreedViewModel]())
    let hideList = Box(true)
    let hideGrid = Box(true)

    init(service: BreedsService,
         imageService: ImageService,
         router: BreedsWireframe,
         availabledWidth: Float) {
        self.service = service
        self.imageService = imageService
        self.router = router
        self.availabledWidth = availabledWidth
    }

    func bootstrap() {
        layoutSwitcherButtons.value = (.system(name: listLayoutFilled), .system(name: gridLayout))
        title.value = viewTitle
        isLoading.value = true
        message.value = loadingMessage
        retry.value = (tryAgainButtonTitle, false)
        service.loadBreeds(page: currentPage) { [weak self] breeds in
            guard let self = self else { return }
            self.isLoading.value = false
            if let breeds = breeds {
                self.didGet(breeds)
            } else {
                self.message.value = self.errorMessage
                self.retry.value = (self.tryAgainButtonTitle, true)
            }
        }
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
        downloadedBreeds = downloadedBreeds + breeds
        self.breeds.value = downloadedBreeds.toViewModel(imageService, availabledWidth: availabledWidth)
    }
    
    private func didGet(_ breeds: [Breed]) {
        if breeds.isEmpty {
            message.value = emptyMessage
        } else {
            currentPage += 1
            message.value = ""
            downloadedBreeds = breeds
            self.breeds.value = downloadedBreeds.toViewModel(imageService, availabledWidth: availabledWidth)
            hideList.value = false
        }
    }

}
