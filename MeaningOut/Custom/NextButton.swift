//
//  NextButton.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit

final class NextButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Meaning.Font.heavy16
        backgroundColor = Meaning.Color.primary
        layer.cornerRadius = 23
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
