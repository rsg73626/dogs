//
//  URL+Extensions.swift
//  Dogs
//
//  Created by Temporary Account on 04/01/22.
//

import Foundation

extension URL {
    
    func appending(queries: [String:String]) -> URL? {
        var urlComps = URLComponents(string: absoluteString)
        urlComps?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComps?.url
    }
    
}
