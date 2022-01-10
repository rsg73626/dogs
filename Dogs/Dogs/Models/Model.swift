//
//  Model.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

enum Model {
    case breed(_ breed: Breed)
    case searchBreed(_ searchBreed: SearchBreed, _ service: SearchBreedService)
}
