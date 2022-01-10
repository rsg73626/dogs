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

    var apiKeyHeaderName = "x-api-key"
    var pageSizeQueryKey = "limit"
    var pageQueryKey = "page"
    var queryQueryKey = "q"
    var decoder = JSONDecoder()
    private let httpClient: HTTPClient
    private let url: URL
    private let apiKey: String?

    init(httpClient: HTTPClient, url: URL, apiKey: String?) {
        self.httpClient = httpClient
        self.url = url
        self.apiKey = apiKey
    }

    func readBreeds(page: Int, size: Int) async throws -> [APIBreed] {
        try await execute([pageSizeQueryKey: "\(size)", pageQueryKey: "\(page)"])
    }
    
    func readBreeds(query: String, page: Int, size: Int) async throws -> [APISearchBreed] {
        try await execute([queryQueryKey: query, pageSizeQueryKey: "\(size)", pageQueryKey: "\(page)"])
    }
    
    static func searchImageURL(imageId: String) -> URL {
        URL(string: "https://api.thedogapi.com/v1/images/\(imageId)")!
    }
    
    private func execute<T: Decodable>(_ queries: [String: String]) async throws -> T {
        guard let url = self.url.appending(queries: queries) else {
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
