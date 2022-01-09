//
//  Box.swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import Foundation

class Box<T> {

    typealias Observer = (T) -> Void

    var observer: Observer?

    var value: T {
        didSet {
            observer?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
}

class MultBox<T>: Box<T> {
    
    var observers: [Observer?] = []
    
    override var value: T {
        didSet {
            observers.forEach { $0?(value) }
        }
    }
    
    override func bind(_ observer: Box<T>.Observer?) {
        self.observers.append(observer)
        observer?(value)
    }
    
}
