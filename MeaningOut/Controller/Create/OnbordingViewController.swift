//
//  OnbordingViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class OnbordingViewController: UIViewController {
    private let onbordingView = OnbordingView()
    
    override func loadView() {
        self.view = onbordingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        navigationItem.backButtonTitle = ""
        onbordingView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        UserDefaults.standard.set(false, forKey: "isCache")
    }
}

//MARK: - Switching View
extension OnbordingViewController {
    @objc func startButtonClicked() {
        navigationController?.pushViewController(SettingProfileViewController(), animated: true)
    }
}
