//
//  BreedService.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

protocol BreedService {
    func downloadImage(formURL url: URL) async -> Data?
}
