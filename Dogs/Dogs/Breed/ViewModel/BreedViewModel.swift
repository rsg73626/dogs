//
//  BreedViewModel.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation
import UIKit

final class BreedViewModel {
    
    enum Model {
        case breed(_ breed: Breed)
        case searchBreed(_ searchBreed: SearchBreed, _ service: SearchBreedService)
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
        case let .searchBreed(searchBreed, service):
            name.value = searchBreed.name
            imageHeight.value = availableWidth
            guard let id = searchBreed.imageId else {
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
