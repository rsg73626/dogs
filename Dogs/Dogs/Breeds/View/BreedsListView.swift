//
//  BreedsListView.swift
//  Dogs
//
//  Created by Temporary Account on 05/01/22.
//

import UIKit

class BreedsListView: UIView {
    
    var viewModels = [BreedViewModel]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    
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
        tableView.register(BreedTableViewCell.self, forCellReuseIdentifier: "BreedTableViewCell")
    }
    
}

extension BreedsListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as? BreedTableViewCell
        cell?.configure(viewModel: viewModels[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}
