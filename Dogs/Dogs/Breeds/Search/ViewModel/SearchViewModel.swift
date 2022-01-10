//
//  swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

final class SearchViewModel {
    
    var viewTitle = ""
    var searchBarPlaceholder = ""
    var errorMessage = ""
    var emptyMessage = ""
    var loadingMessage = ""
    var enterSomeTextMessage = ""
    var tryAgainButtonTitle = ""
    var listLayout = ""
    var listLayoutFilled = ""
    var gridLayout = ""
    var gridLayoutFilled = ""
    var sortImage = ""
    var sortedImage = ""
    
    private let service: SearchService
    private let imageService: ImageService
    private let router: BreedsWireframe
    private let availabledWidth: Float
    
    private var query = ""
    private var paging = false
    private var didEndPaging = false
    private var currentPage: Int = 0
    private var sorted = false
    
    private var downloadedBreeds = [SearchBreed]()
    private var currentBreeds: [SearchBreed] {
        sorted ? downloadedBreeds.sorted { $0.name < $1.name } : downloadedBreeds
    }
    private var currentSortButtonImage: Image {
        .system(name: sorted ? sortedImage : sortImage)
    }

    let layoutSwitcherButtons = Box((list: Image.system(name: ""), grid: Image.system(name: "")))
    let sortButton = Box(Image.system(name: ""))
    let searchPlaceholder = Box("")
    let title = Box("")
    let isLoading = Box(true)
    let isPaging = Box(false)
    let message = Box("")
    let retry = Box((title: "", visible: false))
    let breeds = Box([BreedViewModel]())
    let hideList = Box(true)
    let hideGrid = Box(true)

    init(service: SearchService,
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
        sortButton.value = currentSortButtonImage
        title.value = viewTitle
        searchPlaceholder.value = searchBarPlaceholder
        isLoading.value = false
        message.value = enterSomeTextMessage
        retry.value = (tryAgainButtonTitle, false)
    }

    func didSelectBreed(at index: Int) {
//        router.showBreedDetails(downloadedBreeds[index])
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
        breeds.value = currentBreeds.toViewModel(imageService, availabledWidth: availabledWidth)
        sortButton.value = currentSortButtonImage
    }
    
    func didEnter(text: String) {
        self.query = text
        downloadedBreeds = []
        breeds.value = []
        isLoading.value = true
        message.value = loadingMessage
        guard not(text.replacingOccurrences(of: " ", with: "").isEmpty) else {
            message.value = enterSomeTextMessage
            return
        }
        service.loadBreeds(query: text, page: currentPage) { [weak self] breeds in
            guard let self = self else { return }
            if let breeds = breeds {
                self.didGet(breeds, false)
            } else {
                self.message.value = self.errorMessage
                self.retry.value = (self.tryAgainButtonTitle, true)
            }
        }
    }
    
    private func getNextPage() {
        guard paging == false, didEndPaging == false else { return }
        isPaging.value = true
        service.loadBreeds(query: query, page: currentPage) { [weak self] breeds in
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
    
    private func didGetPage(_ breeds: [SearchBreed]) {
        currentPage += 1
        downloadedBreeds = downloadedBreeds + breeds
        self.breeds.value = currentBreeds.toViewModel(imageService, availabledWidth: availabledWidth)
    }
    
    private func didGet(_ breeds: [SearchBreed], _ incrementPage: Bool) {
        if breeds.isEmpty {
            message.value = emptyMessage
        } else {
            currentPage += incrementPage ? 1 : 0
            message.value = ""
            downloadedBreeds = breeds
            self.breeds.value = currentBreeds.toViewModel(imageService, availabledWidth: availabledWidth)
            hideList.value = false
        }
    }
    
}
