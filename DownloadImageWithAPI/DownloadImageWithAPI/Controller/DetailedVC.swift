//
//  DetailedVC.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 6.10.22.
//

import UIKit

class DetailedVC: UIViewController {
    
    
    lazy var layout: DetailedVCLayout = .init()
    var unsplashPhotoManager = UnsplashPhotoManager()
    var photoObject: PhotoModel? = nil
    var fromSearchCollection = false
    
    override func loadView() {
        super.loadView()
        view = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unsplashPhotoManager.delegate = self
        fetchDownloadsLocationInfo(fromSearchCollection)
        configureNavBar()
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
    
    @objc func addToFavorite() {
        
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

//MARK: - Hide NavigationBar on Tap to make image fullscreen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
}


//MARK: - Extension top present InfoVC in DetailedVC

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








//    func layoutAllElements() {
//        if let photo = photoObject {
////            layout.photoView.loadImageFromURL(photo.regularPhoto)
//            layout.dateCreated.attributedText = addSymbolPrefix(with: Symbols.calendar.rawValue, for: photo.dateCreated.formatToDate!)
//            layout.authorName.attributedText = addSymbolPrefix(with: Symbols.person.rawValue, for: photo.authorName)
//            layout.downloadsAmount.attributedText = addSymbolPrefix(with: Symbols.downloadArrow.rawValue, for: String(photo.downloads))
//
//            switch photo.location {
//            case (let city?, let country?):
//                layout.location.attributedText = addSymbolPrefix(with: Symbols.location.rawValue, for: "\(String(describing: city)), \(String(describing: country))")
//            default:
//                layout.location.attributedText = addSymbolPrefix(with: Symbols.location.rawValue, for: "Earth")
//            }
//
//
//        }
//    }
