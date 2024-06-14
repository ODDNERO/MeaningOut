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
    }
}

//MARK: - Switching View
extension OnbordingViewController {
    
}
