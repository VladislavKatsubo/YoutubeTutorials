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
        photoView.contentMode = .scaleAspectFill
        photoView.activityView.center = photoView.center
        photoView.activityView.frame = photoView.frame
        return photoView
    }()
    
    let authorName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    let dateCreated: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let downloadsAmount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let location: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .white
        return label
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
        addSubview(authorName)
        authorName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(downloadsAmount)
        downloadsAmount.translatesAutoresizingMaskIntoConstraints = false
        addSubview(location)
        location.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateCreated)
        dateCreated.translatesAutoresizingMaskIntoConstraints = false
        
        let nameDownloadsStack = UIStackView(arrangedSubviews: [authorName, downloadsAmount])
        nameDownloadsStack.translatesAutoresizingMaskIntoConstraints = false
        nameDownloadsStack.axis = .vertical
        nameDownloadsStack.distribution = .fillProportionally
        nameDownloadsStack.spacing = 10
        addSubview(nameDownloadsStack)
        
        let dateLocationStack = UIStackView(arrangedSubviews: [dateCreated, location])
        dateLocationStack.translatesAutoresizingMaskIntoConstraints = false
        dateLocationStack.axis = .vertical
        dateLocationStack.distribution = .fillProportionally
        dateLocationStack.spacing = 10
        addSubview(dateLocationStack)
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            photoView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.85),
            
            nameDownloadsStack.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10),
            nameDownloadsStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            nameDownloadsStack.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            
            dateLocationStack.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10),
            dateLocationStack.leadingAnchor.constraint(equalTo: nameDownloadsStack.trailingAnchor),
            dateLocationStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
        ])
    }
    
}
