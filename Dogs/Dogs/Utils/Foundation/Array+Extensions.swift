//
//  Array+Extensions.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

extension Array where Element == Breed {

    func toViewModel(_ imageService: ImageService, availabledWidth: Float) -> [BreedViewModel] {
        map { BreedViewModel(model: .breed($0), imageService: imageService, availableWidth: availabledWidth) }
    }

}

extension Array where Element == SearchBreed {

    func toViewModel(_ imageService: ImageService, _ searchBreedService: SearchBreedService, availabledWidth: Float) -> [BreedViewModel] {
        map { BreedViewModel(model: .searchBreed($0, searchBreedService), imageService: imageService, availableWidth: availabledWidth) }
    }

}
