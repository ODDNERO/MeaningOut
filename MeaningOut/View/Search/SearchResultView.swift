//
//  SearchResultView.swift
//  MeaningOut
//
//  Created by NERO on 6/23/24.
//

import UIKit

class SearchResultView: UIView {
    
    private var searchResultLabel = {
        let label = UILabel()
        label.textColor = Meaning.Color.primary
        label.font = Meaning.Font.black15
        return label
    }()
    
    let accuracySortButton = {
        let button = UIButton()
        button.setTitle("정확도", for: .normal)
        button.titleLabel?.font = Meaning.Font.medium14
        button.layer.cornerRadius = 17
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return button
    }()
    let dateSortButton = {
        let button = UIButton()
        button.setTitle("날짜순", for: .normal)
        button.titleLabel?.font = Meaning.Font.medium14
        button.layer.cornerRadius = 17
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return button
    }()
    let highPriceSortButton = {
        let button = UIButton()
        button.setTitle("가격높은순", for: .normal)
        button.titleLabel?.font = Meaning.Font.medium14
        button.layer.cornerRadius = 17
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return button
    }()
    let lowPriceSortButton = {
        let button = UIButton()
        button.setTitle("가격낮은순", for: .normal)
        button.titleLabel?.font = Meaning.Font.medium14
        button.layer.cornerRadius = 17
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return button
    }()
    private let filterStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

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
    var productList: [Item] = [] {
        didSet {
            collectionView.reloadData()
        }
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
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        cell.update(data: productList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productList[indexPath.row].link
    }
}

extension SearchResultView {
    private func configureSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        setClickedButtonUI(accuracySortButton)
    }
    
    func update(data: ProductDTO) {
        searchResultLabel.text = "\(data.total)개의 검색 결과"
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
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
//            $0.height.equalTo(30)
        }
        
        filterStackView.snp.makeConstraints {
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(filterStackView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
