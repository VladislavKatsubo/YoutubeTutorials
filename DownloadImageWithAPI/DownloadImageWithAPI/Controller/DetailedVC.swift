//
//  DetailedVC.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 6.10.22.
//

import UIKit

class DetailedVC: UIViewController {

    lazy var layout: DetailedVCLayout = .init()
    var photoToShow: UIImage? = nil
    
    override func loadView() {
        super.loadView()
        view = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let photoToShow = photoToShow {
            layout.photoView.image = photoToShow
        }

    }

}
