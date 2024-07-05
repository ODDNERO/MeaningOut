//
//  SearchView.swift
//  MeaningOut
//
//  Created by NERO on 7/5/24.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        searchBar.tintColor = .black
        searchBar.layer.cornerRadius = 8
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    private let underlineView = Meaning.Underline.navigationBar
    
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
    
    private let headerView = UIView()
    private let recentSearchLabel = {
        let label = UILabel()
        label.text = "최근 검색"
        label.textColor = .black
        label.font = Meaning.Font.black15
        label.textAlignment = .left
        return label
    }()
    let removeAllButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(Meaning.Color.primary, for: .normal)
        button.titleLabel?.font = Meaning.Font.medium14
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    private func configureView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        self.addGestureRecognizer(tap)
        self.backgroundColor = Meaning.Color.background
        tableView.separatorColor = .clear
    }
    @objc func keyboardDismiss() {
        self.endEditing(true)
    }
    
    func settingView(searchWords: [String]) {
        switch searchWords.isEmpty {
        case true:
            emptyImageView.isHidden = false
            emptryTextLabel.isHidden = false
            headerView.isHidden = true
            tableView.isHidden = true
        case false:
            emptyImageView.isHidden = true
            emptryTextLabel.isHidden = true
            headerView.isHidden = false
            tableView.isHidden = false
        }
    }
    
    private func configureHierarchy() {
        [searchBar, underlineView, emptyImageView, emptryTextLabel, headerView, tableView].forEach {
            self.addSubview($0)
        }
        [recentSearchLabel, removeAllButton].forEach { headerView.addSubview($0) }
    }
    
    private func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(0.5)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        emptryTextLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(emptyImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }

        headerView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        recentSearchLabel.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.leading.equalTo(headerView).offset(20)
        }
        removeAllButton.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.trailing.equalTo(headerView).inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
