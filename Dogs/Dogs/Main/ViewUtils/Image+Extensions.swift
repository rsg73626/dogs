//
//  Image+Extensions.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import UIKit

extension Image {
    
    func toUIImage() -> UIImage? {
        switch self {
        case let .data(data):
            return UIImage(data: data)
            
        case let .named(name):
            return UIImage(named: name)
            
        }
    }
    
}
