//
//  SwipingController+extension.swift
//  Onboarding Pages AutoLayout Prorgrammatically
//
//  Created by Vlad Katsubo on 8.10.22.
//

import UIKit

//MARK: - Landscape Layout fix
extension SwipingController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { (_) in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } completion: { (_) in

        }
    }

}
