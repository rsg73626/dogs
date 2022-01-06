//
//  BreedServiceCompositor.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

protocol BreedServiceCompositor: BreedService {
    var composed: BreedService? { get set }
}
