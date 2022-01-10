//
//  BreedsRouter.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import UIKit

final class BreedsRouter: BreedsWireframe {
    
    weak var view: UIViewController?
    
    func showBreedDetails(_ model: Model) {
        view?.show(BreedDetailsViewBuilder.build(model: model), sender: view)
    }
    
}
