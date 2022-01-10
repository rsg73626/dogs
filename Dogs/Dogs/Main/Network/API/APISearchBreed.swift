//
//  APISearchBreed.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

struct APISearchBreed: Decodable {
    let id: Int
    let name: String
    let temperament: String?
    let life_span: String
    let alt_names: String?
    let wikipedia_url: URL?
    let origin: String?
    let country_code: String?
    let breed_group: String?
    let reference_image_id: String?
}
