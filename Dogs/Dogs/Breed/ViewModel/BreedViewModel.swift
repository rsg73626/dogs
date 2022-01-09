//
//  BreedViewModel.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

final class BreedViewModel {
    
    private let service: BreedService
    private let breed: Breed
    private let availableWidth: Float
    
    let isLoading = MultBox(true)
    let image = MultBox(Image.named(name: ""))
    let name = MultBox("")
    let imageHeight = MultBox(Float.zero)
    let backgroundHeight = MultBox(Float(64))
    
    init(breed: Breed, service: BreedService, availableWidth: Float) {
        self.breed = breed
        self.service = service
        self.availableWidth = availableWidth
    }
    
    func bootstrap() {
        name.value = breed.name
        imageHeight.value = (breed.imageHeigh * availableWidth)/breed.imageWidth
        service.downloadImage(formURL: breed.image) { [weak self] data in
            if let safeData = data {
                self?.isLoading.value = false
                self?.image.value = .data(data: safeData)
            }
        }
    }
}
