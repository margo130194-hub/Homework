//
//  SceneDelegate.swift
//  Homework 11
//
//  Created by Margarita Matsonko on 29/01/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene

        let vc = ViewController()
        let navVC = UINavigationController(rootViewController: vc)

        window?.makeKeyAndVisible()
        window?.rootViewController = navVC
    }
}
