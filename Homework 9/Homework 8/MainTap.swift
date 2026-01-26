//
//  MainTap.swift
//  Homework 8
//
//  Created by Margarita Matsonko on 26/01/2026.
//


import UIKit

class MainTabBarViewController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let firstVC = FirstViewController()
        let secondVC = FavoriteViewController()
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        firstNav.tabBarItem = UITabBarItem(
            title: "home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        secondNav.tabBarItem  = UITabBarItem(
            title: "favorite",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        viewControllers  = [firstNav, secondNav]
        
    }
}
