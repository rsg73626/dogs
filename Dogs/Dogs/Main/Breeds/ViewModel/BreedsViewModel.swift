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
    private static var errorMessage: String = ""
    private static var emptyMessage: String = ""
    private static var loadingMessage: String = ""

    let options = Box([String]())
    let isLoading = Box(true)
    let message = Box("")
    let retry = Box((title: "", visible: false))
    let breeds = Box([BreedViewModel]())

    init(service: BreedsService, breedService: BreedService, availabledWidth: Float, errorMessage: String, emptyMessage: String, loadingMessage: String) {
        self.service = service
        self.breedService = breedService
        self.availabledWidth = availabledWidth
        BreedsViewModel.errorMessage = errorMessage
        BreedsViewModel.emptyMessage = emptyMessage
        BreedsViewModel.loadingMessage = loadingMessage
    }

    func bootstrap() {
        isLoading.value = true
        message.value = BreedsViewModel.loadingMessage
        service.loadBreeds { [weak self] breeds in
            guard let self = self else { return }
            self.isLoading.value = false
            if let breeds = breeds {
                if breeds.isEmpty {
                    self.message.value = BreedsViewModel.emptyMessage
                } else {
                    self.message.value = ""
                    self.breeds.value = self.breeds.value + breeds.toViewModel(self.breedService, availabledWidth: self.availabledWidth)
                }
            } else {
                self.message.value = BreedsViewModel.errorMessage
            }
        }
    }

    func didSelectOption(at index: Int) {

    }

    func didSelectBreed(at index: Int) {

    }

    func willShowBreed(at index: Int) {

    }

}

private extension Array where Element == Breed {

    func toViewModel(_ service: BreedService, availabledWidth: Float) -> [BreedViewModel] {
        map { BreedViewModel(breed: $0, service: service, availableWidth: availabledWidth) }
    }
}
