//
//  SwipingController.swift
//  Onboarding Pages AutoLayout Prorgrammatically
//
//  Created by Vlad Katsubo on 8.10.22.
//

import Foundation
import UIKit

class SwipingController: UICollectionViewController {
    
    let pages = [
        Page(imageName: "bear_first", headerText: "Hello first screen!", bodyText: "You will become iOS Developer"),
        Page(imageName: "heart_second", headerText: "Hello second screen!!", bodyText: "You will become iOS Developer"),
        Page(imageName: "leaf_third", headerText: "Hello third screen!!!", bodyText: "You will become iOS Developer")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.isPagingEnabled = true
        
        setupBottomControls()
    }
    
    
    
    //MARK: - Scroll method to change pagination
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let currentPageValue = Int(x / view.frame.width)
        pageControl.currentPage = currentPageValue
    }
    
    //MARK: - StackView with pagination and buttons
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePrevious() {
        let previousIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        pageControl.currentPage = previousIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .systemBlue
        return pc
    }()
    
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
}
