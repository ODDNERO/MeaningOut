//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

class SearchViewController: UIViewController {
    let userNickname = UserDefaults.standard.string(forKey: "userNickname")!
    
    override func loadView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation(title: "\(userNickname)'s MEANING OUT", rightBarItem: nil)
    }
}

extension SearchViewController {
    
}
