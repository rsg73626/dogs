//
//  BreedsViewModel.swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import Foundation

final class BreedsViewModel {

    let service: BreedsService

    private let errorMessage: String
    private let emptyMessage: String
    private let loadingMessage: String

    let options = Box([String]())
    let isLoading = Box(true)
    let message = Box("")
    let retry = Box((title: "", visible: false))
    let breeds = Box([(name: String, image: Image)]())

    init(service: BreedsService, errorMessage: String, emptyMessage: String, loadingMessage: String) {
        self.service = service
        self.errorMessage = errorMessage
        self.emptyMessage = emptyMessage
        self.loadingMessage = loadingMessage
    }

    func bootstrap() {
        message.value = loadingMessage
        Task {
            _ = try await service.loadBreeds()
        }
    }

    func didSelectOption(at index: Int) {

    }

    func didSelectBreed(at index: Int) {

    }

    func willShowBreed(at index: Int) {

    }

}
