//
//  SwipingController+UICollectionView.swift
//  Onboarding Pages AutoLayout Prorgrammatically
//
//  Created by Vlad Katsubo on 8.10.22.
//

import UIKit

extension SwipingController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
        //        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        //        cell.bearImageView.image = UIImage(named: page.imageName)
        //        cell.descriptionTextView.text = page.headerText
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
