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
        let mainListNav = UINavigationController(rootViewController: mainListViewController)
        mainListViewController.setupStandartNavigationItem()
        
        let detailViewController = DetailViewController()
        let detailNav = UINavigationController(rootViewController: detailViewController)
        detailViewController.setupStandartNavigationItem()
        
        mainListViewController.delegate = detailViewController
        splitViewController.viewControllers = [mainListNav, detailNav]

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = splitViewController
        window.makeKeyAndVisible()

        self.window = window
    }
}

