//
//  SceneDelegate.swift
//  RedditApp
//
//  Created by Râmede on 10/08/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let splitViewController =  UISplitViewController()
        let mainListViewController = MainListFactory.make()
        let detailViewController = DetailViewController()
        mainListViewController.delegate = detailViewController
        splitViewController.viewControllers = [mainListViewController, detailViewController]

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = splitViewController
        window.makeKeyAndVisible()

        self.window = window
    }
}

