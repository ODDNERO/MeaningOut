//
//  SettingProfileViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

class SettingProfileViewController: UIViewController {
    private let settingProfileView = SettingProfileView()
    
    override func loadView() {
        self.view = settingProfileView
        settingNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK: - Switching View
extension SettingProfileViewController {
    func settingNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
}
