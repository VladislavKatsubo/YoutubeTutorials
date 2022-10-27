//
//  DetailedVCLayout.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 6.10.22.
//

import Foundation
import UIKit

class DetailedVCLayout: UIView {
    
    var photoView: CustomImageView = {
        let photoView = CustomImageView()
        photoView.clipsToBounds = true
        photoView.contentMode = .scaleAspectFit
        
        return photoView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureScreen() {
        backgroundColor = .black
        addSubview(photoView)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photoView.activityView)
        photoView.activityView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            photoView.activityView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            photoView.activityView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
        
}
