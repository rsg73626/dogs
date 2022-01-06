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
        label.textAlignment = .center
        return label
    }()

    lazy var retryButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var list: BreedsListView = {
        BreedsListView(frame: view.frame)
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
    
    @objc private func didPressTryAgain() {
        viewModel?.bootstrap()
    }
    
    @objc private func didSelectOption() {
        viewModel?.didSelectOption(at: toggler.selectedSegmentIndex)
    }

    private func setUpViews() {
        view.backgroundColor = .systemBackground
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
        retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 32).isActive = true
        retryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        retryButton.addTarget(self, action: #selector(didPressTryAgain), for: .touchUpInside)
        retryButton.setTitleColor(.systemBlue, for: .normal)
        
        view.addSubview(list)
        list.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        list.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        list.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        list.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        list.tableView.delegate = self
    }

    private func bind() {
        guard let viewModel = self.viewModel else { return }
        viewModel.title.bind { [weak self] title in
            self?.navigationItem.title = title
        }
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
        viewModel.breeds.bind { [weak self] viewModels in
            self?.list.configure(viewModels: viewModels)
        }
        viewModel.hideList.bind { [weak self] isHidden in
            self?.list.isHidden = isHidden
        }
        viewModel.hideGrid.bind { /*[weak self]*/ isHidden in
            print(isHidden)
        }
        viewModel.isPaging.bind { [weak self] paging in
            self?.list.loadingContainer.isHidden = paging == false
        }
    }

}

extension BreedsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.willShowBreed(at: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectBreed(at: indexPath.section)
    }
    
}


