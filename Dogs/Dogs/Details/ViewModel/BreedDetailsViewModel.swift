//
//  BreedDetailsViewModel.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

final class BreedDetailsViewModel {
    
    private let model: Breed
    private let imageService: ImageService
    
    let title = Box("")
    let isLoading = Box(true)
    let image = Box(Image.named(name: ""))
    let name = Box("")
    let category = Box("")
    let origin = Box("")
    let temperament = Box("")
    
    init(model: Breed, imageService: ImageService) {
        self.model = model
        self.imageService = imageService
    }
    
    func bootstrap() {
        title.value = "BreedDetails.title".localized
        name.value = model.name
        category.value = String(format: "BreedDetails.category".localized, model.category.nonEmpty)
        origin.value = String(format: "BreedDetails.origin".localized, model.origin.nonEmpty)
        temperament.value = String(format: "BreedDetails.temperament".localized, model.temperament.nonEmpty)
        imageService.downloadImage(formURL: model.image) { [weak self] data in
            self?.isLoading.value = false
            if let safeData = data {
                self?.image.value = .data(data: safeData)
            }
        }
    }
    
}
