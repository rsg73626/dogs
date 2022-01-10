//
//  Array+Extensions.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

extension Array where Element == Breed {

    func toViewModel(_ service: BreedService, availabledWidth: Float) -> [BreedViewModel] {
        map { BreedViewModel(breed: $0, service: service, availableWidth: availabledWidth) }
    }

}
