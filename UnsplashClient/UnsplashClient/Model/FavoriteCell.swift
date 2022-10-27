//
//  FavoriteCell.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 19.10.22.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let identifier = "FavoriteCell"
    
    var photoImageView = CustomImageView()
    var nameLocationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(photoImageView)
        addSubview(photoImageView.activityView)
        addSubview(nameLocationLabel)
        configureImageView()
        configureLabel()
        setLabelConstraints()
        setImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(with data: PhotoModel) {
        photoImageView.loadImageFromURL(data.smallPhoto)
        nameLocationLabel.text = data.authorName
    }
 
    func configureImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
    }
    
    func configureLabel() {
        nameLocationLabel.numberOfLines = 0
        nameLocationLabel.adjustsFontSizeToFitWidth = true
        nameLocationLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLocationLabel.textColor = .white
    }
    
    func setImageConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.activityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            photoImageView.activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoImageView.activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setLabelConstraints() {
        nameLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLocationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLocationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
