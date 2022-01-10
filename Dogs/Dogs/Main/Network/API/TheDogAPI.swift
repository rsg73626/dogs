//
//  TheDogAPI.swift
//  Dogs
//
//  Created by Temporary Account on 04/01/22.
//

import Foundation

final class TheDogAPI {

    enum Error: Swift.Error {
        case invalidURL
        case invalidData
    }

    var baseURL = "https://api.thedogapi.com/v1"
    var apiKeyHeaderName = "x-api-key"
    var pageSizeQueryKey = "limit"
    var pageQueryKey = "page"
    var queryQueryKey = "q"
    var decoder = JSONDecoder()
    private let httpClient: HTTPClient
    private let apiKey: String?
    
    var list: URL {
        URL(string: baseURL + "/breeds")!
    }
    
    var search: URL {
        URL(string: baseURL + "/breeds/search")!
    }
    
    func imageURL(imageId: String) -> URL {
        URL(string: baseURL + "/images/\(imageId)")!
    }

    init(httpClient: HTTPClient, apiKey: String?) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }

    func readBreeds(page: Int, size: Int) async throws -> [APIBreed] {
        try await execute(list, [pageSizeQueryKey: "\(size)", pageQueryKey: "\(page)"])
    }
    
    func readBreeds(query: String, page: Int, size: Int) async throws -> [APISearchBreed] {
        try await execute(search, [queryQueryKey: query, pageSizeQueryKey: "\(size)", pageQueryKey: "\(page)"])
    }
    
    func redImage(id: String) async throws -> APIBreedImage {
        try await execute(imageURL(imageId: id), [:])
    }
    
    private func execute<T: Decodable>(_ url: URL, _ queries: [String: String]) async throws -> T {
        guard let url = url.appending(queries: queries) else {
            throw Error.invalidURL
        }
        let headers = apiKey != nil ? [apiKeyHeaderName: apiKey!] : [:]
        let result = try? await httpClient.fetchData(url: url, headers: headers)
        guard let data = result?.data, let breeds = try? decoder.decode(T.self, from: data) else {
            throw Error.invalidData
        }
        return breeds
    }
}
