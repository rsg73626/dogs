//
//  BreedView.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import UIKit

final class BreedView: UIView {
    
    let nameHeight: CGFloat
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nameLabel: UILabel! = {
        let label = UILabel()
        return label
    }()
    
    init(frame: CGRect, nameHeight: CGFloat) {
        self.nameHeight = nameHeight
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        self.nameHeight = .zero
        super.init(coder: coder)
        setUpViews()
    }
    
    private func setUpViews() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: nameHeight).isActive = true
        imageView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        
        backgroundView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
    }
    
}
