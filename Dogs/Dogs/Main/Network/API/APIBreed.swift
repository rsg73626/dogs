//
//  APIBreed.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

struct APIBreed: Decodable {
    let id: Int
    let name: String
    let temperament: String?
    let life_span: String
    let alt_names: String?
    let wikipedia_url: URL?
    let origin: String?
    let country_code: String?
    let image: APIImage
    let breed_group: String?
}

struct APIImage: Decodable {
    let id: String
    let height: Float
    let width: Float
    let url: URL
}
