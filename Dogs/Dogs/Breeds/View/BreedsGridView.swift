//
//  BreedsGridView.swift
//  Dogs
//
//  Created by Temporary Account on 06/01/22.
//

import UIKit

class BreedsGridView: UIView {
    
    private let loadingCellId = "LoadingViewCell"
    var viewModels = [BreedViewModel]()
    var willDisplayBreedAt: ((Int) -> Void)?
    var didSelectBreedAt: ((Int) -> Void)?
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: layout)
        return collection
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
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
        collectionView.reloadData()
    }
    
    private func setUpViews() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BreedCollectionViewCell.self, forCellWithReuseIdentifier: "BreedCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: loadingCellId)
    }
    
}

extension BreedsGridView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == .zero ? viewModels.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == .zero {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedCollectionViewCell", for: indexPath) as? BreedCollectionViewCell
            cell?.configure(viewModel: viewModels[indexPath.row])
            cell?.breedView.imageView.contentMode = .scaleAspectFill
            cell?.breedView.layer.cornerRadius = 15
            cell?.breedView.clipsToBounds = true
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loadingCellId, for: indexPath)
            cell.addSubview(loadingView)
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == .zero {
            let side = (collectionView.frame.width / 2) - 12
            return CGSize(width: side, height: (side * 1.5) + 64)
        } else {
            return CGSize(width: collectionView.frame.width - 6, height: 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 3, bottom: 8, right: 3)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplayBreedAt?(indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == .zero { didSelectBreedAt?(indexPath.item) }
    }

}
