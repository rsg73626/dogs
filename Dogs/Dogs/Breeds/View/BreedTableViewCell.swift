//
//  BreedTableViewCell.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import UIKit

final class BreedTableViewCell: UITableViewCell {
    
    lazy var breedView: BreedView = {
        let view = BreedView(frame: frame)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
