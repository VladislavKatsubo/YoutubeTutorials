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
        photoView.contentMode = .scaleAspectFill

        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        photoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        photoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
