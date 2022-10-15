//
//  DetailedVC.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 6.10.22.
//

import UIKit

class DetailedVC: UIViewController {
    
    
    lazy var layout: DetailedVCLayout = .init()
    
    var photoObject: PhotoModel? = nil
    
    override func loadView() {
        super.loadView()
        view = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutAllElements()
        configureNavBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showInfo))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hello() {
        print("hello")
    }
    
    func layoutAllElements() {
        if let photo = photoObject {
//            layout.photoView.loadImageFromURL(photo.regularPhoto)
            layout.dateCreated.attributedText = addSymbolPrefix(with: Symbols.calendar.rawValue, for: photo.dateCreated.formatToDate!)
            layout.authorName.attributedText = addSymbolPrefix(with: Symbols.person.rawValue, for: photo.authorName)
            layout.downloadsAmount.attributedText = addSymbolPrefix(with: Symbols.downloadArrow.rawValue, for: String(photo.downloads))
            
            switch photo.location {
            case (let city?, let country?):
                layout.location.attributedText = addSymbolPrefix(with: Symbols.location.rawValue, for: "\(String(describing: city)), \(String(describing: country))")
            default:
                layout.location.attributedText = addSymbolPrefix(with: Symbols.location.rawValue, for: "Earth")
            }
            
            
        }
    }
    
    
    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func showInfo() {
        let infoVC = InfoVC()
        infoVC.modalPresentationStyle = .custom
        infoVC.transitioningDelegate = self
        present(infoVC, animated: true)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.hidesBarsOnTap = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.hidesBarsOnTap = false
//    }
    
    
}


//MARK: - Extension top present InfoVC in DetailedVC

extension DetailedVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
