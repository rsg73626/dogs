//
//  BreedView.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import UIKit

final class BreedView: UIView {
    
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
    
    private var imageHeight: NSLayoutConstraint?
    private var backgroundHeight: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
    
    func configure(viewModel: BreedViewModel) {
        viewModel.isLoading.bind { [weak self] isLoading in
            isLoading ? self?.loadingView.startAnimating() : self?.loadingView.stopAnimating()
        }
        viewModel.image.bind { [weak self] image in
            self?.imageView.image = image.toUIImage()
        }
        viewModel.name.bind { [weak self] name in
            self?.nameLabel.text = name
        }
        viewModel.imageHeight.bind { [weak self] height in
            self?.imageHeight?.constant = CGFloat(height)
        }
        viewModel.backgroundHeight.bind { [weak self] height in
            self?.backgroundHeight?.constant = CGFloat(height)
        }
        viewModel.bootstrap()
    }
    
    private func setUpViews() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        imageView.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundView.backgroundColor = .systemGray5
        imageView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        
        backgroundView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        
        imageHeight = imageView.heightAnchor.constraint(equalToConstant: .leastNonzeroMagnitude)
        imageHeight?.isActive = true
        backgroundHeight = backgroundView.heightAnchor.constraint(equalToConstant: .leastNonzeroMagnitude)
        backgroundHeight?.isActive = true

    }
    
}
