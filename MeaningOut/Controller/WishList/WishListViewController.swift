//
//  WishListViewController.swift
//  MeaningOut
//
//  Created by NERO on 7/5/24.
//

import UIKit

final class WishListViewController: UIViewController {
    private let wishListView = WishListView()
    
    override func loadView() {
        self.view = wishListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
