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
        
        layout.itemSize = CGSize(width: width/2, height: (width/2) * 1.7)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSetting()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultView {
    private func configureSetting() {
        self.backgroundColor = Meaning.Color.background
        setClickedButtonUI(accuracySortButton)
    }
    
    func update(data: Product) {
        let total = Meaning.Method.formatNumber(data.total)
        searchResultLabel.text = "\(total)개의 검색 결과"
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
        }
        filterStackView.snp.makeConstraints {
            $0.top.equalTo(searchResultLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filterStackView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
