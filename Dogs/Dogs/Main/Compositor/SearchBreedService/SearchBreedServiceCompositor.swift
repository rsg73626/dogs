//
//  SearchBreedServiceCompositor.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

protocol SearchBreedServiceCompositor: SearchBreedService {
    var composed: SearchBreedService? { get set }
}
