//
//  BreedServiceAdapter.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

final class BreedServiceAdapter: BreedService {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func downloadImage(formURL url: URL) async -> Data? {
        (try? await httpClient.fetchData(url: url, headers: [:]))?.data
    }
}
