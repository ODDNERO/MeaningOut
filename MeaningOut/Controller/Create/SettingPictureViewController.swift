//
//  SettingPictureViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class SettingPictureViewController: UIViewController {
    private let settingPictureView = SettingPictureView()
    
    override func loadView() {
        super.loadView()
        self.view = settingPictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigation(title: "PROFILE SETTING", rightBarItem: nil)
    }
}

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SettingPictureViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return UIViewControllerType()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
