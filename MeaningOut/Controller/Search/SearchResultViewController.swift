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
    
    override func loadView() {
        super.loadView()
        self.view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingNavigation(title: searchKeyword, rightBarItem: nil)
        requestProductData(sort: .sim)
    }
}

extension SearchResultViewController {
    func requestProductData(sort: Sort) {
        let url = NaverAPI.baseURL
        let header: HTTPHeaders = ["X-Naver-Client-Id": NaverAPI.clientID,
                                   "X-Naver-Client-Secret": NaverAPI.clientSecret]
        let parameter: Parameters = ["query": searchKeyword,
                                     "sort": sort.rawValue]
        
        AF.request(url, method: .get,
                   parameters: parameter,
                   headers: header)
        .responseDecodable(of: ProductDTO.self) { response in
            switch response.result {
            case .success(let product):
                self.productList = product.items
                self.searchResultView.productData = product
            case .failure(let error):
                print(error)
            }
        }
    }
}
