//
//  DetailController.swift
//  UICollectionView - Programmatically
//
//  Created by Vlad Katsubo on 29.09.22.
//

import UIKit

class DetailController: UIViewController {
    
    var imageToShow: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            return imageView
        }()
        detailImageView.frame = view.bounds
        detailImageView.contentMode = .scaleAspectFill
        
        if let imageToShow = imageToShow {
            detailImageView.image = imageToShow
        }
        
        
        view.addSubview(detailImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
