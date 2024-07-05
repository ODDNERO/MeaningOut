//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/22/24.
//

import UIKit

final class SearchResultViewController: UIViewController {
    var searchKeyword: String = ""
    private let searchResultView = SearchResultView()
    
    private var productList: [Item] = [] {
        willSet {
            searchResultView.productList = newValue
        }
    }
    
    private let itemsPerPage = 30
    private var totalCount = 0
    private var startData = 1
    private var isEnd = false {
        didSet {
            searchResultView.isEnd = self.isEnd
        }
    }
    
    private lazy var totalPages = (totalCount + itemsPerPage - 1) / itemsPerPage
    private var page: Int = 1 {
        didSet {
            searchResultView.page = self.page
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        searchResultView.navigationController = self.navigationController
    }
}

extension SearchResultViewController {
    private func incrementPage() {
        searchResultView.nextPage = {
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
