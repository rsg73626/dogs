//
//  ImageService.swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import Foundation

protocol BreedsService {
    func loadBreeds(page: Int, completion: @escaping ([Breed]?) -> Void)
}
