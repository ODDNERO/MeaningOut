//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/22/24.
//

import UIKit

final class SearchResultViewController: UIViewController {
    private let searchResultView = SearchResultView()
    private var productList: [Item] = [] {
        didSet {
            searchResultView.collectionView.reloadData()
        }
    }
    
    var searchKeyword: String = ""
    private var totalCount = 0
    private let itemsPerPage = 30
    private lazy var totalPages = (totalCount + itemsPerPage - 1) / itemsPerPage
    private var page = 1
    private var startData = 1
    private var isEnd = false
    
    override func loadView() {
        super.loadView()
        self.view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingNavigation(title: searchKeyword, rightBarItem: nil)
        SearchManager.shared.requestProductData(searchKeyword, sort: .sim, itemsPerPage: itemsPerPage, start: startData) { product, error in
            if let error {
                print(error)
            } else {
                guard let product else { return }
                self.paginateData(data: product)
            }
        }
        incrementPage()
    }
}

extension SearchResultViewController {
    private func settingDelegate() {
        searchResultView.collectionView.delegate = self
        searchResultView.collectionView.dataSource = self
        searchResultView.collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        searchResultView.collectionView.prefetchDataSource = self
    }
    
    private func incrementPage() {
            self.page += 1
            self.startData += self.itemsPerPage
            SearchManager.shared.requestProductData(self.searchKeyword, sort: .sim, itemsPerPage: self.itemsPerPage, start: self.startData) { product, error in
                if let error {
                    print(error)
                } else {
                    guard let product else { return }
                    self.paginateData(data: product)
                }
            }
    }
    
    private func paginateData(data: Product) {
        self.totalCount = data.total
        if self.page == 1 {
            self.productList = data.items
        } else {
            self.productList.append(contentsOf: data.items)
        }
        self.searchResultView.update(data: data)
        self.isEnd = self.page == self.totalPages
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        cell.update(data: productList[indexPath.row])
        
        cell.productImageView.tag = indexPath.row
        cell.productImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(productImageClicked)))
        return cell
    }
    @objc func productImageClicked(sender: UITapGestureRecognizer) {
    let productWebVC = ProductWebViewController()
        productWebVC.selectedProductName = productList[sender.view!.tag].title
        productWebVC.productURL = productList[sender.view!.tag].link
        navigationController?.pushViewController(productWebVC, animated: true)
    }
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if productList.count - 2 == item.row && isEnd == false {
                incrementPage()
            }
        }
    }
}
