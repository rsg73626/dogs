//
//  SearchBreedService.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

protocol SearchBreedService {
    func getImageURL(imageId: String, completion: @escaping (URL?) -> Void)
}
