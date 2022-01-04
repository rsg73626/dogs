//
//  HTTPClient.swift
//  Dogs
//
//  Created by Temporary Account on 04/01/22.
//

import Foundation

protocol HTTPClient {
    typealias HTTPClientResult = (response: HTTPURLResponse, data: Data)

    func fetchData(url: URL, headers: [String: String]) async throws -> HTTPClientResult
}
