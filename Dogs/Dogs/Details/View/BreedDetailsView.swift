//
//  BreedDetailsView.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import UIKit

final class BreedDetailsView: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    lazy var originLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    lazy var temperamentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    var viewModel: BreedDetailsViewModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        bind()
        viewModel?.bootstrap()
    }
    
    private func setUpViews() {
        view.backgroundColor = .systemBackground
        
        [imageView, nameLabel, categoryLabel, originLabel, temperamentLabel].forEach { [weak self] v in
            self?.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        originLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8).isActive = true
        originLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        originLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        temperamentLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 8).isActive = true
        temperamentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        temperamentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func bind() {
        viewModel?.title.bind { [weak self] value in
            self?.navigationItem.title = value
        }
        viewModel?.isLoading.bind { [weak self] value in
            value ? self?.loadingView.startAnimating() : self?.loadingView.stopAnimating()
        }
        viewModel?.image.bind { [weak self] value in
            self?.imageView.image = value.toUIImage()
        }
        viewModel?.name.bind { [weak self] value in
            self?.nameLabel.text = value
        }
        viewModel?.category.bind { [weak self] value in
            self?.categoryLabel.text = value
        }
        viewModel?.origin.bind { [weak self] value in
            self?.originLabel.text = value
        }
        viewModel?.temperament.bind { [weak self] value in
            self?.temperamentLabel.text = value
        }
    }

}
