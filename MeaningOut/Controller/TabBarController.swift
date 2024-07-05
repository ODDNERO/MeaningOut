//
//  TabBarController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = Meaning.Color.primary
        tabBar.unselectedItemTintColor = Meaning.Color.gray2
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: Meaning.Image.search, tag: 0)
        
        let wishListVC = UINavigationController(rootViewController: WishListViewController())
        wishListVC.tabBarItem = UITabBarItem(title: "위시", image: Meaning.Image.heart, selectedImage: Meaning.Image.fillHeart)
        
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        settingVC.tabBarItem = UITabBarItem(title: "설정", image: Meaning.Image.person, tag: 2)
        
        setViewControllers([searchVC, wishListVC, settingVC], animated: true)
        selectedIndex = 1
    }
}
