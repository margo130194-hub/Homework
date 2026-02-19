//
//  SceneDelegate.swift
//  Homework 16
//
//  Created by Margarita Matsonko on 18/02/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        let vc = PanViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
        window?.makeKeyAndVisible()
        window?.rootViewController = navVC
    }
}
