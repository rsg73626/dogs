//
//  BreedsServiceCompletionDispatcher.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

final class BreedsServiceCompletionDispatcher: BreedsServiceCompositor {
    
    var composed: BreedsService?
    let queue: DispatchQueue
    
    init(queue: DispatchQueue = .main) {
        self.queue = queue
    }
    
    func loadBreeds(completion: @escaping ([Breed]?) -> Void) {
        composed?.loadBreeds { [weak self] result in
            self?.queue.async {
                completion(result)
            }
        }
    }
    
}
