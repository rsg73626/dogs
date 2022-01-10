//
//  SearchBreedServiceCompletionDispatcher.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

final class SearchBreedServiceCompletionDispatcher: SearchBreedServiceCompositor {
    
    var composed: SearchBreedService?
    var queue: DispatchQueue
    
    init(queue: DispatchQueue = .main) {
        self.queue = queue
    }
    
    func getImageURL(imageId: String, completion: @escaping (URL?) -> Void) {
        composed?.getImageURL(imageId: imageId) { [weak self] url in
            self?.queue.async {
                completion(url)
            }
        }
    }
}
