//
//  ImageServiceCompositor.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

protocol ImageServiceCompositor: ImageService {
    var composed: ImageService? { get set }
}
