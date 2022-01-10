//
//  Array+Extensions.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

extension Array where Element == APIBreed {
    
    func toModel() -> [Breed] {
        map { Breed(name: $0.name,
                    image: $0.image.url,
                    imageWidth: $0.image.width,
                    imageHeigh: $0.image.height,
                    category: $0.breed_group ?? "",
                    origin: $0.origin ?? "",
                    temperament: $0.temperament ?? "") }
    }
    
}

extension Array where Element == APISearchBreed {
    
    func toModel() -> [SearchBreed] {
        map { SearchBreed(name: $0.name,
                          imageId: $0.reference_image_id ?? "", 
                          category: $0.breed_group ?? "", 
                          origin: $0.origin ?? "", 
                          temperament: $0.temperament ?? "") }
    }
    
}
