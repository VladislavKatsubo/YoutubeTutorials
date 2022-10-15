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
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .systemBlue
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBottomControls()
    }
    

    
    fileprivate func setupBottomControls() {
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(previousButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        let stackView = UIStackView(arrangedSubviews: [
            previousButton, pageControl, nextButton
        ])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setupLayout() {
        let topContainer = UIView()
        view.addSubview(topContainer)
        view.addSubview(bearImageView)
        view.addSubview(descriptionTextView)
        topContainer.addSubview(bearImageView)
        
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        bearImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            //topContainer for imageView
            topContainer.topAnchor.constraint(equalTo: view.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            //imageView
            bearImageView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            bearImageView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            bearImageView.heightAnchor.constraint(equalTo: topContainer.heightAnchor, multiplier: 0.5),
            
            //textview
            descriptionTextView.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
}

