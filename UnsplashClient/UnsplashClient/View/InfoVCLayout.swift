//
//  InfoVCLayout.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 15.10.22.
//

import Foundation
import UIKit

class InfoVCLayout: UIView {
    
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
        addSubview(downloadsAmount)
        downloadsAmount.translatesAutoresizingMaskIntoConstraints = false
        addSubview(location)
        location.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateCreated)
        dateCreated.translatesAutoresizingMaskIntoConstraints = false
        
        let dateLocationDownloadsStack = UIStackView(arrangedSubviews: [dateCreated, location, downloadsAmount])
        dateLocationDownloadsStack.translatesAutoresizingMaskIntoConstraints = false
        dateLocationDownloadsStack.axis = .vertical
        dateLocationDownloadsStack.distribution = .fillProportionally
        addSubview(dateLocationDownloadsStack)
        
        NSLayoutConstraint.activate([
            dateLocationDownloadsStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLocationDownloadsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLocationDownloadsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLocationDownloadsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
}
