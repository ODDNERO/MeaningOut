//
//  SearchResultView.swift
//  MeaningOut
//
//  Created by NERO on 6/23/24.
//

import UIKit

class SearchResultView: UIView {
    var searchResultLabel = {
        let label = UILabel()
        return label
    }()
    
    let accuracySortButton = {
        let button = UIButton()
        button.setTitle("정확도", for: .normal)
        button.titleLabel?.font = Meaning.Font.medium15
        button.configuration?.cornerStyle = .capsule
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    let dateSortButton = {
        let button = UIButton()
        button.setTitle("날짜순", for: .normal)
        button.titleLabel?.font = Meaning.Font.medium15
        button.configuration?.cornerStyle = .capsule
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    let highPriceSortButton = {
        let button = UIButton()
        button.setTitle("가격높은순", for: .normal)
        button.titleLabel?.font = Meaning.Font.medium15
        button.configuration?.cornerStyle = .capsule
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    let lowPriceSortButton = {
        let button = UIButton()
        button.setTitle("가격낮은순", for: .normal)
        button.titleLabel?.font = Meaning.Font.medium15
        button.configuration?.cornerStyle = .capsule
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    private let filterStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
//        stackView.distribution = .
        stackView.spacing = 10
        return stackView
    }()
    
//    var productList: []
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 1)
        
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Meaning.Color.background
        configureSetting()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return //
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
//        cell.

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension SearchResultView {
    private func configureSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    func setClickedButtonUI(_ sender: UIButton) {
        [accuracySortButton, dateSortButton, highPriceSortButton, lowPriceSortButton].forEach {
            $0.backgroundColor = .clear
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = Meaning.Color.gray1.cgColor
        }
        
        sender.backgroundColor = Meaning.Color.gray3
        sender.setTitleColor(.white, for: .normal)
        sender.layer.borderWidth = 0
    }
    
    private func configureHierarchy() {
        [searchResultLabel, filterStackView, collectionView].forEach { self.addSubview($0) }
        
        [accuracySortButton, dateSortButton, highPriceSortButton, lowPriceSortButton].forEach {
            filterStackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        searchResultLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            
        }
        
        filterStackView.snp.makeConstraints {
            $0.top.equalTo(searchResultLabel.snp.bottom)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(30)
        }
        accuracySortButton.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
//        dateSortButton.snp.makeConstraints {
//            $0
//        }
//        highPriceSortButton.snp.makeConstraints {
//            $0
//        }
//        lowPriceSortButton.snp.makeConstraints {
//            $0
//        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filterStackView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
