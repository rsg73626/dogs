//
//  BreedViewModel.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

final class BreedViewModel {
    
    enum Model {
        case breed(_ breed: Breed)
        case searchBreed(_ searchBreed: SearchBreed)
    }
    
    private let imageService: ImageService
    private let model: Model
    private let availableWidth: Float
    
    let isLoading = MultBox(true)
    let image = MultBox(Image.named(name: ""))
    let name = MultBox("")
    let imageHeight = MultBox(Float.zero)
    let backgroundHeight = MultBox(Float(64))
    
    init(model: Model, imageService: ImageService, availableWidth: Float) {
        self.model = model
        self.imageService = imageService
        self.availableWidth = availableWidth
    }
    
    func bootstrap() {
        switch model {
        case let .breed(breed):
            name.value = breed.name
            imageHeight.value = (breed.imageHeigh * availableWidth)/breed.imageWidth
            imageService.downloadImage(formURL: breed.image) { [weak self] data in
                if let safeData = data {
                    self?.isLoading.value = false
                    self?.image.value = .data(data: safeData)
                }
            }
        case let .searchBreed(searchBreed):
            print(searchBreed)
        }
    }
}
