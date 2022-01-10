//
//  BreedCollectionViewCell.swift
//  Dogs
//
//  Created by Temporary Account on 06/01/22.
//

import UIKit

class BreedCollectionViewCell: UICollectionViewCell {
    
    lazy var breedView: BreedView = {
       BreedView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
    
    func configure(viewModel: BreedViewModel) {
        breedView.configure(viewModel: viewModel)
    }
    
    private func setUpViews() {
        addSubview(breedView)
        breedView.translatesAutoresizingMaskIntoConstraints = false
        breedView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        breedView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        breedView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        breedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
