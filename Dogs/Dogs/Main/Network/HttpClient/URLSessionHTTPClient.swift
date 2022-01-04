//
//  URLSessionHTTPClient.swift
//  Dogs
//
//  Created by Temporary Account on 04/01/22.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {

    var session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData(url: URL, headers: [String : String]) async throws -> HTTPClient.HTTPClientResult {
        var request = URLRequest(url: url)
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        let result = try? await session.data(for: request, delegate: nil)
        guard let response = result?.1 as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }
        guard let data = result?.0 else {
            throw HTTPClientError.emptyData
        }
        return (response, data)
    }
}
