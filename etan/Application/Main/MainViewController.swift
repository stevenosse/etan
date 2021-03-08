//
//  MainViewController.swift
//  etan
//
//  Created by Nossedjou Steve on 03/03/2021.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    func setupTabBar() {
        let stopsViewController = UINavigationController(rootViewController: StopsViewController())
        stopsViewController.tabBarItem.image = UIImage(systemName: "alt")
        stopsViewController.tabBarItem.title = "Arrêts"
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem.image = UIImage(systemName: "heart")
        favoritesViewController.tabBarItem.title = "Favoris"
        
        viewControllers = [stopsViewController, favoritesViewController]
    }

}
