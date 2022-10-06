//
//  ViewController.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 29.09.22.
//

import UIKit

class MainScreenVC: UIViewController {
    
    lazy var contentView: MainScreenLayout = .init()
    var unsplashPhotoManager = UnsplashPhotoManager()
    var photoData = [PhotoModel]()
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.collectionView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.searchBar.delegate = self
        showSearchBarButton(true)
        
        configureNavBar()
        
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.configureCollectionView()
        
        unsplashPhotoManager.delegate = self
        print("I'm loading it again")
        unsplashPhotoManager.fetchPhotos()
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    // action for search button
    @objc func showSearchBar() {
        contentView.configureSearchBar()
        search(true)
    }
    
    // show/hide search button on the nav bar
    func showSearchBarButton(_ shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .search,
                target: self,
                action: #selector(showSearchBar)
            )
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    // short function to show/hide search field
    func search(_ shouldShow: Bool) {
        showSearchBarButton( !shouldShow)
        contentView.searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? contentView.searchBar : nil
    }
    
}


//MARK: - UISearchBar Methods
extension MainScreenVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var query = searchBar.text else { return }
        unsplashPhotoManager.fetchPhotos(with: &query)
        search(false)
        searchBar.text = ""
    }
}

//MARK: - UICollectionViewDelegate methods
extension MainScreenVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageCell = contentView.collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        let dc = DetailedVC()
        
        dc.modalTransitionStyle = .flipHorizontal
        dc.modalPresentationStyle = .popover
        dc.photoToShow = imageCell.imageView.image
        present(dc, animated: true)
    }
}

//MARK: - UICollectionViewDataSoruce methods
extension MainScreenVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = contentView.collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let photoURL = photoData[indexPath.row].regularPhoto
        DispatchQueue.main.async {
            imageCell.imageView.loadImageFromURL(photoURL)
        }
        return imageCell
    }
    
    
}

//MARK: - UICollectionViewFlowLayoutDelegate methods
extension MainScreenVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((view.frame.size.width/2)-2), height: ((view.frame.size.height/3)-3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

//MARK: - UnsplashManagerDelegate methods
extension MainScreenVC: UnsplashDataDelegate {
    func updateUI(with photoModels: [PhotoModel]) {
        
        DispatchQueue.main.async {
            self.photoData.removeAll()
            self.photoData = photoModels
            self.contentView.collectionView.reloadData()
        }
    }
}
