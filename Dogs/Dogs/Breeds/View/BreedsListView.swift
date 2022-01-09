//
//  BreedsListView.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import UIKit

class BreedsListView: UIView {
    
    var viewModels = [BreedViewModel]()
    var willDisplayBreedAt: ((Int) -> Void)?
    var didSelectBreedAt: ((Int) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: frame, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    lazy var loadingContainer: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
    
    func configure(viewModels: [BreedViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    private func setUpViews() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BreedTableViewCell.self, forCellReuseIdentifier: "BreedTableViewCell")
        
        tableView.tableFooterView = loadingContainer
        loadingContainer.frame.size = CGSize(width: tableView.frame.width, height: 64)
        
        loadingContainer.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: loadingContainer.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: loadingContainer.centerYAnchor).isActive = true
    }
    
}

extension BreedsListView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as? BreedTableViewCell
        cell?.configure(viewModel: viewModels[indexPath.section])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        willDisplayBreedAt?(indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectBreedAt?(indexPath.section)
    }
    
}
