//
//  BreedsServiceCompositor.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

protocol BreedsServiceCompositor: BreedsService {
    var composed: BreedsService? { get set }
}
