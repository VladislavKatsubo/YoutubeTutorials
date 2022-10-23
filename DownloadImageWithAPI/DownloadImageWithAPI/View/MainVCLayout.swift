//
//  MainScreenLayout.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 2.10.22.
//

import Foundation
import UIKit

class MainVCLayout: UIView {
    
    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let photoCell = PhotoCollectionViewCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - SearchBar configuration
    @objc func configureSearchBar() {
        searchBar.isTranslucent = false
        searchBar.searchBarStyle = .default
        searchBar.placeholder = " Nature..."
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        addSubview(searchBar)
    }
    
    //MARK: - CollectionView configuration
    func configureCollectionView() {
        addSubview(collectionView)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
    }
    
}

