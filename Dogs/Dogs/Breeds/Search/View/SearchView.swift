//
//  SearchView.swift
//  Dogs
//
//  Created by Temporary Account on 09/01/22.
//

import UIKit

final class SearchView: UIViewController {
    
    var viewModel: SearchViewModel?
    
    lazy var listLayout: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: ""),
                        style: .plain,
                        target: self,
                        action: #selector(didPressListLayout))
    }()
    
    lazy var gridLayout: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: ""),
                        style: .plain,
                        target: self,
                        action: #selector(didPressGridLayout))
    }()
    
    lazy var sortButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: #selector(didPressSort))
    }()
    
    lazy var searchBar: UISearchBar = {
        UISearchBar()
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
    
    lazy var grid: BreedsGridView = {
        BreedsGridView(frame: view.frame)
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
    
    @objc private func didPressListLayout() {
        viewModel?.didSelectListLayout()
    }
    
    @objc private func didPressGridLayout() {
        viewModel?.didSelectGridLayout()
    }
    
    @objc private func didPressTryAgain() {
        viewModel?.didEnter(text: searchBar.text ?? "")
    }
    
    @objc private func didPressSort() {
        viewModel?.didPressSort()
    }

    private func setUpViews() {
        navigationItem.leftBarButtonItems = [listLayout, gridLayout]
        navigationItem.rightBarButtonItems = [sortButton]
        
        navigationItem.titleView = searchBar
        searchBar.returnKeyType = .done
        searchBar.delegate = self
        
        view.backgroundColor = .systemBackground
        [messageLabel, loading, retryButton, list].forEach { [weak self] v in
            self?.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true

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
        list.willDisplayBreedAt = viewModel?.willShowBreed(at:)
        list.didSelectBreedAt = viewModel?.didSelectBreed(at:)
        
        view.addSubview(grid)
        grid.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        grid.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        grid.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        grid.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        grid.willDisplayBreedAt = viewModel?.willShowBreed(at:)
        grid.didSelectBreedAt = viewModel?.didSelectBreed(at:)
    }

    private func bind() {
        guard let viewModel = self.viewModel else { return }
        viewModel.layoutSwitcherButtons.bind { [weak self] list, grid in
            self?.listLayout.image = list.toUIImage()
            self?.gridLayout.image = grid.toUIImage()
        }
        viewModel.layoutAvailability.bind { [weak self] list, grid in
            self?.listLayout.isEnabled = list
            self?.gridLayout.isEnabled = grid
        }
        viewModel.sortButton.bind { [weak self] image in
            self?.sortButton.image = image.toUIImage()
        }
        viewModel.title.bind { [weak self] title in
            self?.navigationItem.title = title
        }
        viewModel.searchPlaceholder.bind { [weak self] placeholder in
            self?.searchBar.placeholder = placeholder
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
            self?.grid.configure(viewModels: viewModels)
        }
        viewModel.hideList.bind { [weak self] isHidden in
            self?.list.isHidden = isHidden
        }
        viewModel.hideGrid.bind { [weak self] isHidden in
            self?.grid.isHidden = isHidden
        }
        viewModel.isPaging.bind { [weak self] paging in
            self?.list.loadingContainer.isHidden = paging == false
            paging ? self?.grid.loadingView.startAnimating() : self?.grid.loadingView.stopAnimating()
        }
        viewModel.hideList.bind { [weak self] isHidden in
            self?.list.isHidden = isHidden
        }
        viewModel.hideGrid.bind { [weak self] isHidden in
            self?.grid.isHidden = isHidden
        }
    }
    
}

extension SearchView: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.leftBarButtonItems = []
        navigationItem.rightBarButtonItems = []
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationItem.leftBarButtonItems = [listLayout, gridLayout]
        navigationItem.rightBarButtonItems = [sortButton]
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.didEnter(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
