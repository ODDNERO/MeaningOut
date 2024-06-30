//
//  SearchManager.swift
//  MeaningOut
//
//  Created by NERO on 6/29/24.
//

import Foundation

enum Sort: String {
    case sim
    case date
    case asc
    case dsc
}

class SearchManager {
    static let shared = SearchManager()
    private init() { }
    
    func requestData(_ searchWord: String, sort: Sort, queryItems: [String: Int],
                     completionHandler: @escaping (Product?, NetworkError?) -> Void) {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "openapi.naver.com"
        component.path = "v1/search/shop.json"
        if let itemsPerPage = queryItems["itemsPerPage"], let start = queryItems["start"] {
            component.queryItems = [
                URLQueryItem(name: "query", value: searchWord),
                URLQueryItem(name: "sort", value: sort.rawValue),
                URLQueryItem(name: "display", value: String(itemsPerPage)),
                URLQueryItem(name: "start", value: String(start))
            ]
            
            var request = URLRequest(url: component.url!, timeoutInterval: 5)
            request.setValue(NaverAPI.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
            request.setValue(NaverAPI.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    guard error == nil else {
                        print("Failed Request")
                        completionHandler(nil, .failedRequest)
                        return
                    }
                    
                    guard let data else {
                        print("No Data Returned")
                        completionHandler(nil, .noData)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse else {
                        print("Unable Response")
                        completionHandler(nil, .invalidResponse)
                        return
                    }
                    
                    guard response.statusCode == 200 else {
                        print("failed Response")
                        completionHandler(nil, .invalidResponse)
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(Product.self, from: data)
                        print("<<< SUCCESS >>> ", result)
                        completionHandler(result, nil)
                    } catch {
                        print("<<< ERROR >>> ", error)
                        completionHandler(nil, .invalidData)
                    }
                }
            }.resume()
        }
    }
}
