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
    private let emptryTextLabel = {
        let label = UILabel()
        label.text = "최근 검색어가 없어요"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = Meaning.Font.black16
        return label
    }()
    
    private var userSearchWords: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "userSearchWords") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userSearchWords")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation(title: "\(userNickname)'s MEANING OUT", rightBarItem: nil)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingView()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        userSearchWords.append(searchText)
        view.endEditing(true)
        
        navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
}

extension SearchViewController {
    private func configureView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tap)
        view.backgroundColor = Meaning.Color.background
        searchBar.delegate = self
    }
    
    func settingView() {
        switch userSearchWords.isEmpty {
        case true:
            emptyImageView.isHidden = false
            emptryTextLabel.isHidden = false
        case false:
            emptyImageView.isHidden = true
            emptryTextLabel.isHidden = true
        }
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    private func configureHierarchy() {
        [searchBar, underlineView, emptyImageView, emptryTextLabel].forEach {
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
        emptryTextLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(emptyImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
