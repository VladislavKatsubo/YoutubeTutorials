//
//  DetailedVC.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 6.10.22.
//

import UIKit
import RealmSwift

class DetailedVC: UIViewController {
    
    let realm = try! Realm()
    
    lazy var layout: DetailedVCLayout = .init()
    var unsplashPhotoManager = UnsplashPhotoManager()
    var photoObject: PhotoModel? = nil
    var fromSearchCollection = false
    var fullScreen: Bool = false
    
    override func loadView() {
        super.loadView()
        view = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unsplashPhotoManager.delegate = self
        fetchDownloadsLocationInfo(fromSearchCollection)
        configureNavBar()
        fetchButtonColor()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureNavBar() {
        navigationItem.title = photoObject?.authorName
        let info = UIBarButtonItem(image: UIImage(systemName: Symbols.info.rawValue), style: .plain, target: self, action: #selector(showInfo))
        let favorite = UIBarButtonItem(image: UIImage(systemName: Symbols.favorite.rawValue), style: .plain, target: self, action: #selector(addToFavorite))
        navigationItem.rightBarButtonItems = [favorite, info]
    }
    //show infoVC at the bottom of the page
    @objc func showInfo() {
        let infoVC = InfoVC()
        infoVC.modalPresentationStyle = .custom
        infoVC.transitioningDelegate = self
        infoVC.photoObject = photoObject
        present(infoVC, animated: true)
    }
    
    // add photo to the RealmDB and FavoriteVC
    @objc func addToFavorite() {
        guard let photoObject = photoObject else { return }
        if realm.objects(PhotoModel.self).filter("id == %@", photoObject.id).isEmpty {
            saveToDB(photoObject)
            fetchButtonColor()
        } else {
            let ac = UIAlertController(title: "Warning", message: "Do you want to delete\nthis photo from Favorites", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self]_ in
                self?.navigationItem.rightBarButtonItems?[0].tintColor = .white
                self?.deleteFromDB(photoObject.id)
                if let parentControllerName = self?.navigationController?.viewControllers.first?.title {
                    if parentControllerName == "Favorites" {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            })
            present(ac, animated: true)
        }
        
}
    
    
    func fetchDownloadsLocationInfo(_ proceed: Bool) {
        if proceed {
            if let photoObject = photoObject {
                if photoObject.downloads == nil {
                    unsplashPhotoManager.getInfoForID(with: photoObject.id)
                }
            }
        }
    }
    
    func showAlertWhenDeleting() {
        guard let photoObject = photoObject else { return }
        if realm.objects(PhotoModel.self).filter({ $0.id == photoObject.id }).isEmpty {
//            save
        } else {
            
        }
    }
    
    func fetchButtonColor() {
        guard let photoObject = photoObject else { return }
        let itemFound = realm.objects(PhotoModel.self).filter("id == %@", photoObject.id).isEmpty
        navigationItem.rightBarButtonItems?[0].tintColor = itemFound ? .white : .yellow
    }
    
    
    //MARK: - Hide NavigationBar on Tap to make image fullscreen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
//MARK: - Make Photo "fullscreen" on tap
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        scaleAspect()
    }
    
    func scaleAspect() {
        fullScreen.toggle()
        layout.photoView.contentMode = fullScreen ? .scaleAspectFill : .scaleAspectFit
    }
    
}


//MARK: - Extension to present InfoVC in DetailedVC

extension DetailedVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension DetailedVC: UnsplashDataDelegate {
    func updateUI(with photoModels: [PhotoModel]) {
        self.photoObject?.location = photoModels[0].location
        self.photoObject?.downloads = photoModels[0].downloads
    }
}

//MARK: - Realm Database methods

extension DetailedVC {
    func saveToDB(_ photoModel: PhotoModel) {
        realm.beginWrite()
        let copy = realm.create(PhotoModel.self, value: photoModel, update: .all)
        realm.add(copy, update: .all)
        try! realm.commitWrite()
    }
    
    func deleteFromDB(_ id: String) {
        realm.beginWrite()
        realm.delete(realm.objects(PhotoModel.self).filter("id == %@", id)[0].location!)
        realm.delete(realm.objects(PhotoModel.self).filter("id == %@", id))
        try! realm.commitWrite()
    }
}

