//
//  BreedsView.swift
//  Dogs
//
//  Created by Temporary Account on 03/01/22.
//

import UIKit

final class BreedsView: UIViewController {

    var viewModel: BreedsViewModel?
    
    lazy var toggler: UISegmentedControl = {
        UISegmentedControl()
    }()
    
    lazy var loading: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()

    lazy var retryButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var list: UITableView = {
        UITableView(frame: .zero, style: .plain)
    }()

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
    
    @objc private func didSelectOption() {
        viewModel?.didSelectOption(at: toggler.selectedSegmentIndex)
    }

    private func setUpViews() {
        view.backgroundColor = .white
        navigationItem.titleView = toggler
        [messageLabel, loading, retryButton, list].forEach { [weak self] v in
            self?.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        toggler.addTarget(self, action: #selector(didSelectOption), for: .valueChanged)

        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8).isActive = true

        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loading.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -32).isActive = true

        retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        retryButton.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 32).isActive = true
    }

    private func bind() {
        guard let viewModel = self.viewModel else { return }
        viewModel.options.bind { [weak self] options in
            self?.toggler.removeAllSegments()
            for option in options.enumerated() {
                self?.toggler.insertSegment(withTitle: option.element, at: option.offset, animated: false)
            }
        }
        viewModel.isLoading.bind { [weak self] isLoading in
            isLoading ? self?.loading.startAnimating() : self?.loading.stopAnimating()
        }
        viewModel.message.bind { [weak self] message in
            self?.messageLabel.text = message
        }
        viewModel.retry.bind { [weak self] title, visible in
            self?.retryButton.setTitle(title, for: .normal)
            self?.retryButton.isHidden = visible == false
        }
        viewModel.breeds.bind { [weak self] _ in
            self?.list.reloadData()
        }
    }

}
