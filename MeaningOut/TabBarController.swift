//
//  TabBarController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = Meaning.Color.primary
        tabBar.unselectedItemTintColor = Meaning.Color.gray2
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: Meaning.Image.search, tag: 0)
        
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        settingVC.tabBarItem = UITabBarItem(title: "설정", image: Meaning.Image.person, tag: 1)
        
        setViewControllers([searchVC, settingVC], animated: true)
    }
}
