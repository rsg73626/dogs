//
//  SearchServiceAdapter.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

final class SearchServiceAdapter: SearchService {
    
    static var pageSize: Int = 20
    let api: TheDogAPI
    
    init(api: TheDogAPI, pageSize: Int = 20) {
        self.api = api
        SearchServiceAdapter.pageSize = pageSize
    }
    
    func loadBreeds(query: String, page: Int, completion: @escaping ([SearchBreed]?) -> Void) {
        Task.detached { [weak self] in
            completion(try? await self?.api.readBreeds(query: query, page: page, size: SearchServiceAdapter.pageSize).toModel())
        }
    }
    
}
