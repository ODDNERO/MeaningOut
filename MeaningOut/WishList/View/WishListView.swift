//
//  WishListView.swift
//  MeaningOut
//
//  Created by NERO on 7/5/24.
//

import UIKit
import SnapKit

final class WishListView: UIView {
    let searchTextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 2
        textField.layer.borderColor = Meaning.Color.primary.cgColor
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        textField.font = Meaning.Font.semi15
        textField.tintColor = Meaning.Color.primary
        textField.attributedPlaceholder = NSAttributedString(string: " 🔍 위시 아이템 이름 검색 ", attributes: [.foregroundColor: Meaning.Color.primary.withAlphaComponent(0.7), .font: Meaning.Font.medium15])
        textField.textAlignment = .center
        return textField
    }()
    let wishTableView = UITableView()
    
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

extension WishListView {
    private func configureHierarchy() {
        [searchTextField, wishTableView].forEach { self.addSubview($0) }
    }
    
    private func configureLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(60)
            $0.height.equalTo(40)
        }
        wishTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
