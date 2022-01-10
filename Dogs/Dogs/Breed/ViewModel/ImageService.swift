//
//  BreedService.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

protocol ImageService {
    func downloadImage(formURL url: URL, completion: @escaping (Data?) -> Void)
}
