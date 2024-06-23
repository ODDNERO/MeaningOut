//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/22/24.
//

import UIKit
import Alamofire

enum Sort: String {
    case sim
    case date
    case asc
    case dsc
}

final class SearchResultViewController: UIViewController {
    var searchKeyword: String = ""
    private let searchResultView = SearchResultView()
     
    override func loadView() {
        super.loadView()
        self.view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingNavigation(title: searchKeyword, rightBarItem: nil)
    }
}
