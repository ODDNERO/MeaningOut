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
        self.view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        cell.update(data: productList[indexPath.item])
        
        cell.productImageView.tag = indexPath.item
        cell.productImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(productImageClicked)))
        
        cell.wishButton.tag = indexPath.item
        cell.wishButton.addTarget(self, action: #selector(wishButtonClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func productImageClicked(sender: UITapGestureRecognizer) {
    let productWebVC = ProductWebViewController()
        productWebVC.selectedProductName = productList[sender.view!.tag].title
        productWebVC.productURL = productList[sender.view!.tag].link
        navigationController?.pushViewController(productWebVC, animated: true)
    }
    
        if let cell = searchResultView.collectionView.cellForItem(at: IndexPath(item: sender.tag, section: 0)) as? SearchResultCollectionViewCell {
            cell.isFavorite.toggle()
            cell.configureFavoriteButtonUI()
    @objc func wishButtonClicked(_ sender: UIButton) {
        }
    }
    
    private func makeWishItemData(index: Int) -> (WishItem, String) {
        let selectedItemID = productList[index].productId
        let selectedItemTitle = Meaning.Method.removeHTMLTags(text: productList[index].title)
        let selectedItemImageString = productList[index].image
        let selectedItemPrice = Meaning.Method.formatNumber(Int(productList[index].lprice)!) + "원"
        let selectedItemMall = productList[index].mallName
        let selectedItemLink = productList[index].link
        let wishDate = DateFormatter.customFormatter.string(from: Date())
        
        return (WishItem(productID: selectedItemID,
                        title: selectedItemTitle,
                        imageString: selectedItemImageString,
                        price: selectedItemPrice,
                        mallName: selectedItemMall,
                        link: selectedItemLink,
                        wishDate: wishDate), 
                selectedItemID)
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