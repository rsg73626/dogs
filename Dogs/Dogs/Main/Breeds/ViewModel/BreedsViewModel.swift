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
    private let errorMessage: String
    private let emptyMessage: String
    private let loadingMessage: String

    let options = Box([String]())
    let isLoading = Box(true)
    let message = Box("")
    let retry = Box((title: "", visible: false))
    let breeds = Box([BreedViewModel]())

    init(service: BreedsService, breedService: BreedService, errorMessage: String, emptyMessage: String, loadingMessage: String) {
        self.service = service
        self.breedService = breedService
        self.errorMessage = errorMessage
        self.emptyMessage = emptyMessage
        self.loadingMessage = loadingMessage
    }

    func bootstrap() {
        message.value = loadingMessage
        Task {
            let breeds = try await service.loadBreeds()
            isLoading.value = false
            message.value = ""
            let breedService = self.breedService
            self.breeds.value = breeds.map { BreedViewModel(breed: $0, service: breedService) }
        }
    }

    func didSelectOption(at index: Int) {

    }

    func didSelectBreed(at index: Int) {

    }

    func willShowBreed(at index: Int) {

    }

}
