//
//  ViewController.swift
//  Custom UITabBar Programmatically
//
//  Created by Vlad Katsubo on 29.09.22.
//

import RAMAnimatedTabBarController
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.backgroundColor = .systemBlue
        button.center = view.center
        button.setTitle("Show Tab Bar", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func didTapButton() {
        let tabBarVC = CustomTabBarController()
        present(tabBarVC, animated: true)
    }
    
}

class CustomTabBarController: RAMAnimatedTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        tabBar.backgroundColor = .systemBackground
    }
    
    func configure() {
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        let vc4 = UIViewController()
        
        vc1.view.backgroundColor = .systemBrown
        vc2.view.backgroundColor = .systemPink
        vc3.view.backgroundColor = .systemMint
        vc4.view.backgroundColor = .systemIndigo
        
        vc1.tabBarItem = RAMAnimatedTabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 1)
        
        (vc1.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        (vc1.tabBarItem as? RAMAnimatedTabBarItem)?.iconColor = .black
        (vc1.tabBarItem as? RAMAnimatedTabBarItem)?.textColor = .black
        
        vc2.tabBarItem = RAMAnimatedTabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 1)
        
        (vc2.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        (vc2.tabBarItem as? RAMAnimatedTabBarItem)?.iconColor = .black
        (vc2.tabBarItem as? RAMAnimatedTabBarItem)?.textColor = .black
        
        vc3.tabBarItem = RAMAnimatedTabBarItem(
            title: "Activity",
            image: UIImage(systemName: "bell"),
            tag: 1)
        (vc3.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        (vc3.tabBarItem as? RAMAnimatedTabBarItem)?.iconColor = .black
        (vc3.tabBarItem as? RAMAnimatedTabBarItem)?.textColor = .black
        
        vc4.tabBarItem = RAMAnimatedTabBarItem(
            title: "Flights",
            image: UIImage(systemName: "airplane"),
            tag: 1)
        
        (vc4.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        (vc4.tabBarItem as? RAMAnimatedTabBarItem)?.iconColor = .black
        (vc4.tabBarItem as? RAMAnimatedTabBarItem)?.textColor = .black
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: false)
    }
}
