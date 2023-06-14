//
//  HomeScreen.swift
//  Rick & Morty
//
//  Created by Alisher Manatbek on 04.06.2023.
//

import UIKit

class HomeScreen: UITabBarController {
    
    let backroundColor = UIColor(named: "tabBarColorBackround")
    let tintColor = UIColor(named: "tintColor")
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        let vc1 = CharacterScreen()
//        vc1.title = "Character"
        
        let vc2 = LocationScreen()
//        vc2.title = "Location"
        
        let vc3 = EpisodeScreen()
//        vc3.title = "Episode"
        
        let vc4 = SettingsScreen()
//        vc4.title = "Settings"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
//        nav1.navigationBar.prefersLargeTitles = true
//        nav2.navigationBar.prefersLargeTitles = true
//        nav3.navigationBar.prefersLargeTitles = true
//        nav4.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = UITabBarItem(title: "Персонажи", image: UIImage(named: "Subtract.png"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Локации", image: UIImage(named: "Subtract.png"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Эпизоды", image: UIImage(named: "Subtract.png"), tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gearshape"), tag: 1)
        tabBar.tintColor = tintColor
        tabBar.backgroundColor = backroundColor
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBar.layer.shadowRadius = 30
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }

}
