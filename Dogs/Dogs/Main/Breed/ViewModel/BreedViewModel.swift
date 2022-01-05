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
    
    let isLoading = Box(true)
    let image = Box(Image.named(name: ""))
    let name = Box("")
    
    init(breed: Breed, service: BreedService) {
        self.breed = breed
        self.service = service
    }
    
    func bootstrap() {
        name.value = breed.name
        Task {
            if let data = await service.downloadImage(formURL: breed.image) {
                isLoading.value = false
                image.value = .data(data: data)
            }
        }
    }
}
