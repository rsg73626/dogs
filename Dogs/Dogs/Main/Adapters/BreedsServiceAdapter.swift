//
//  BreedsServiceAdapter.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

final class BreedsServiceAdapter: BreedsService {
    
    let api: TheDogAPI
    
    init(api: TheDogAPI) {
        self.api = api
    }
    
    func loadBreeds() async throws -> [Breed] {
        try await api.readBreeds(page: 1, size: 10).toModel()
    }
}

private extension Array where Element == APIBreed {
    
    func toModel() -> [Breed] {
        map { Breed(name: $0.name, image: $0.image.url) }
    }
    
}
