//
//  SearchServiceCompletionDispatcher.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

final class SearchServiceCompletionDispatcher: SearchServiceCompositor {
    
    var composed: SearchService?
    let queue: DispatchQueue
    
    init(queue: DispatchQueue = .main) {
        self.queue = queue
    }
    
    func loadBreeds(query: String, page: Int, completion: @escaping ([SearchBreed]?) -> Void) {
        composed?.loadBreeds(query: query, page: page) { [weak self] breeds in
            self?.queue.async {
                completion(breeds)
            }
        }
    }
}
