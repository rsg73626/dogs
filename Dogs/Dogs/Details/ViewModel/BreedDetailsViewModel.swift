//
//  BreedDetailsViewModel.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

final class BreedDetailsViewModel {
    
    private let model: Model
    private let imageService: ImageService
    
    let title = Box("")
    let isLoading = Box(true)
    let image = Box(Image.named(name: ""))
    let name = Box("")
    let category = Box("")
    let origin = Box("")
    let temperament = Box("")
    
    init(model: Model, imageService: ImageService) {
        self.model = model
        self.imageService = imageService
    }
    
    func bootstrap() {
        title.value = "BreedDetails.title".localized
        switch model {
        case let .breed(breed):
            name.value = breed.name
            category.value = String(format: "BreedDetails.category".localized, breed.category.nonEmpty)
            origin.value = String(format: "BreedDetails.origin".localized, breed.origin.nonEmpty)
            temperament.value = String(format: "BreedDetails.temperament".localized, breed.temperament.nonEmpty)
            imageService.downloadImage(formURL: breed.image) { [weak self] data in
                self?.isLoading.value = false
                if let safeData = data {
                    self?.image.value = .data(data: safeData)
                }
            }
        case let .searchBreed(breed, service):
            name.value = breed.name
            category.value = String(format: "BreedDetails.category".localized, breed.category.nonEmpty)
            origin.value = String(format: "BreedDetails.origin".localized, breed.origin.nonEmpty)
            temperament.value = String(format: "BreedDetails.temperament".localized, breed.temperament.nonEmpty)
            guard let id = breed.imageId else {
                isLoading.value = false
                return
            }
            getImageURL(id, service)
        }
    }
    
    private func getImageURL(_ imageID: String, _ service: SearchBreedService) {
        service.getImageURL(imageId: imageID) { [weak self] url in
            guard let url = url else {
                self?.isLoading.value = false
                return
            }
            self?.getImage(url)
        }
    }
    
    private func getImage(_ url: URL) {
        imageService.downloadImage(formURL: url) { [weak self] data in
            guard let self = self else { return }
            self.isLoading.value = false
            if let data = data {
                self.image.value = .data(data: data)
            }
        }
    }
    
}
