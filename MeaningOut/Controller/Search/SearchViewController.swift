//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/14/24.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    private let userNickname = UserDefaults.standard.string(forKey: "userNickname")!
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        searchBar.tintColor = .black
        searchBar.layer.cornerRadius = 8
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    private let underlineView = Meaning.TextField.grayUnderlineView
    private let emptyImageView = Meaning.ImageView.empty
    private let textLabel = {
        let label = UILabel()
        label.text = "최근 검색어가 없어요"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = Meaning.Font.black16
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation(title: "\(userNickname)'s MEANING OUT", rightBarItem: nil)
        view.backgroundColor = Meaning.Color.background
        configureHierarchy()
        configureLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }
}

extension SearchViewController {
    private func configureHierarchy() {
        [searchBar, underlineView, emptyImageView, textLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        textLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(emptyImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
