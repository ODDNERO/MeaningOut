//
//  SearchResultViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/22/24.
//

import UIKit
import Alamofire

enum Sort: String {
    case sim
    case date
    case asc
    case dsc
}

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
    
    lazy var totalPages = (totalCount + itemsPerPage - 1) / itemsPerPage
    var page: Int = 1 {
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
//        setNavigationBarUnderline()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingNavigation(title: searchKeyword, rightBarItem: nil)
        requestProductData(sort: .sim)
        incrementPage()
    }
}

extension SearchResultViewController {
    func incrementPage() {
        searchResultView.nextPage = {
            self.page += 1
            self.startData += self.itemsPerPage
            self.requestProductData(sort: .sim)
            print("startData: ", self.startData)
        }
    }
        
    func requestProductData(sort: Sort) {
        let url = NaverAPI.baseURL
        let header: HTTPHeaders = ["X-Naver-Client-Id": NaverAPI.clientID,
                                   "X-Naver-Client-Secret": NaverAPI.clientSecret]
        let parameter: Parameters = ["query": searchKeyword,
                                     "sort": sort.rawValue,
                                     "display": itemsPerPage,
                                     "start": startData]
        
        AF.request(url, method: .get,
                   parameters: parameter,
                   headers: header)
        .responseDecodable(of: ProductDTO.self) { response in
            switch response.result {
            case .success(let product):
                self.totalCount = product.total
                
                if self.page == 1 {
                    self.productList = product.items
                } else {
                    self.productList.append(contentsOf: product.items)
                }
                print("productList.count: ", self.productList.count)
                self.searchResultView.update(data: product)
                self.isEnd = self.page == self.totalPages

            case .failure(let error):
                print(error)
            }
        }
    }
}
