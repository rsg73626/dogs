//
//  SearchBreedServiceAdapter.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

final class SearchBreedServiceAdapter: SearchBreedService {
    
    let api: TheDogAPI
    
    init(api: TheDogAPI) {
        self.api = api
    }
    
    func getImageURL(imageId: String, completion: @escaping (URL?) -> Void) {
        Task {
            completion((try? await api.redImage(id: imageId))?.url)
        }
    }
    
}
