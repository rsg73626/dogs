//
//  BreedServiceCompletionDispatcher.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

final class BreedServiceCompletionDispatcher: BreedServiceCompositor {
    
    var composed: BreedService?
    let queue: DispatchQueue
    
    init(queue: DispatchQueue = .main) {
        self.queue = queue
    }
    
    func downloadImage(formURL url: URL, completion: @escaping (Data?) -> Void) {
        composed?.downloadImage(formURL: url) { [weak self] data in
            self?.queue.async {
                completion(data)
            }
        }
    }
    
}
