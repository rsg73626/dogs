//
//  BreedsServiceAdapter.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

final class BreedsServiceAdapter: BreedsService {
    
    static var pageSize: Int = 20
    let api: TheDogAPI
    
    init(api: TheDogAPI, pageSize: Int = 20) {
        self.api = api
        BreedsServiceAdapter.pageSize = pageSize
    }
    
    func loadBreeds(page: Int, completion: @escaping ([Breed]?) -> Void) {
        Task.detached { [weak self] in
            completion(try? await self?.api.readBreeds(page: page, size: BreedsServiceAdapter.pageSize).toModel())
        }
    }
}

private extension Array where Element == APIBreed {
    
    func toModel() -> [Breed] {
        map { Breed(name: $0.name, image: $0.image.url, imageWidth: $0.image.width, imageHeigh: $0.image.height, category: $0.breed_group ?? "", origin: $0.origin ?? "", temperament: $0.temperament ?? "") }
    }
    
}
