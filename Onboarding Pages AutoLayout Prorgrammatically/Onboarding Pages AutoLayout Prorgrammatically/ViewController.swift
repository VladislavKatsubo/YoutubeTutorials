//
//  ViewController.swift
//  Onboarding Pages AutoLayout Prorgrammatically
//
//  Created by Vlad Katsubo on 7.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    let bearImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bear_first"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(
            string: "Join us today in our fun and games!",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            ])
        attributedText.append(NSAttributedString(
            string: "\n\n\nAre you ready to find a iOS Developer Job?",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
            ]))
        //        textView.text = "Join us today in our fun and games!"
        //        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bearImageView)
        view.addSubview(descriptionTextView)
        setupLayout()
    }
    
    func setupLayout() {
        
        let topContainer = UIView()
        view.addSubview(topContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        bearImageView.translatesAutoresizingMaskIntoConstraints = false
        topContainer.addSubview(bearImageView)
        
        
        
        
        NSLayoutConstraint.activate([
            //topcontainer
            topContainer.topAnchor.constraint(equalTo: view.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            
            bearImageView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            bearImageView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            bearImageView.heightAnchor.constraint(equalTo: topContainer.heightAnchor, multiplier: 0.5),
//            bearImageView.widthAnchor.constraint(equalTo: topContainer.heightAnchor, multiplier: 0.5),
            
            //textview
            descriptionTextView.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
}

