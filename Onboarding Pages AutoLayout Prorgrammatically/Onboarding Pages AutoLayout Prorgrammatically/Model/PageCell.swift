//
//  PageCell.swift
//  Onboarding Pages AutoLayout Prorgrammatically
//
//  Created by Vlad Katsubo on 8.10.22.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let pageUnwrapped = page else { return }
            bearImageView.image = UIImage(named: pageUnwrapped.imageName)
            let attributedText = NSMutableAttributedString(
                string: pageUnwrapped.headerText,
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                ])
            attributedText.append(NSAttributedString(
                string: "\n\n\(pageUnwrapped.bodyText)",
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
                ]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    private let bearImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bear_first"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(
            string: "Join us today in our fun and games!",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            ])
        attributedText.append(NSAttributedString(
            string: "\n\nAre you ready to find an iOS Developer Job?",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
            ]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    func setupLayout() {
        let topContainer = UIView()
        addSubview(topContainer)
        addSubview(bearImageView)
        addSubview(descriptionTextView)
        topContainer.addSubview(bearImageView)
        
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        bearImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            //topContainer for imageView
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            //imageView
            bearImageView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            bearImageView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            bearImageView.heightAnchor.constraint(equalTo: topContainer.heightAnchor, multiplier: 0.5),
            
            //textview
            descriptionTextView.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
