//
//  OnbordingView.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit
import SnapKit

final class OnbordingView: UIView {
    private let logoImageView = Meaning.ImageView.logo
    private let launchImageView = Meaning.ImageView.launch
    let startButton = NextButton(title: "시작하기")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Meaning.Color.background
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnbordingView {
    private func configureHierarchy() {
        [logoImageView, launchImageView, startButton].forEach { self.addSubview($0) }
    }
    
    private func configureLayout() {
        [logoImageView, launchImageView, startButton].forEach {
            $0.snp.makeConstraints { $0.centerX.equalTo(self) }
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(self.safeAreaLayoutGuide).inset(100)
            $0.width.equalTo(self).multipliedBy(0.7)
            $0.height.equalTo(logoImageView.snp.width).multipliedBy(1.0 / 6.0)
        }
        
        launchImageView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(72)
            $0.centerY.equalTo(self)
            $0.width.equalTo(self).multipliedBy(0.55)
            $0.height.equalTo(launchImageView.snp.width).multipliedBy(4.0 / 3.0)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.width.equalTo(self).multipliedBy(0.9)
            $0.height.equalTo(startButton.snp.width).multipliedBy(1.0 / 8.0)
        }
    }
}
