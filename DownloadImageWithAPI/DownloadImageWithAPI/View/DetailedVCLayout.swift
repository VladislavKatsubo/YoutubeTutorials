//
//  DetailedVCLayout.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 6.10.22.
//

import Foundation
import UIKit

class DetailedVCLayout: UIView {
    
    let photoView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureScreen() {
        addSubview(photoView)
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.contentMode = .scaleAspectFill

        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: topAnchor),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
        
//        photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
//        photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
//        photoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        photoView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
//        photoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
