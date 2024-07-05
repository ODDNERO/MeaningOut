//
//  WishListView.swift
//  MeaningOut
//
//  Created by NERO on 7/5/24.
//

import UIKit

final class WishListView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Meaning.Color.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
