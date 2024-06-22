//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/22/24.
//

import UIKit

final class SearchResultViewController: UIViewController {
    var searchKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Meaning.Color.background
        settingNavigation(title: searchKeyword, rightBarItem: nil)
    }
}
