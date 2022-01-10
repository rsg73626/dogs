//
//  SearchServiceCompositor.swift
//  Dogs
//
//  Created by Temporary Account on 10/01/22.
//

import Foundation

protocol SearchServiceCompositor: SearchService {
    var composed: SearchService? { get set }
}
