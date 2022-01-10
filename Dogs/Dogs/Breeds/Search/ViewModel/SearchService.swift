//
//  SearchService.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import Foundation

protocol SearchService {
    func loadBreeds(query: String, page: Int, completion: @escaping ([Breed]?) -> Void)
}
