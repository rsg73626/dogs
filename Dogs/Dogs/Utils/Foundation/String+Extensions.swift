//
//  String+Extensions.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    var nonEmpty: String {
        isEmpty ? "-" : self
    }
    
}
