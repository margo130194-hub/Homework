//
//  SceneDelegate.swift
//  Homework 12
//
//  Created by Margarita Matsonko on 03/02/2026.
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
