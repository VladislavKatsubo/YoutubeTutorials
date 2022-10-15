//
//  PresentationController.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 15.10.22.
//

import Foundation
import UIKit

class PresentationController: UIPresentationController {
    
    var blurEffectView: UIVisualEffectView! = nil
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: (self.containerView!.frame.height) * 0.4), size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * 0.6))
    }
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { UIViewControllerTransitionCoordinatorContext in
            self.blurEffectView.alpha = 0.7
        }, completion: { UIViewControllerTransitionCoordinatorContext in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { UIViewControllerTransitionCoordinatorContext in
            self.blurEffectView.alpha = 0
        }, completion: { UIViewControllerTransitionCoordinatorContext in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 22)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true)
    }
}


