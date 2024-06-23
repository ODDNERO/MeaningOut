//
//  ProductWebViewController.swift
//  MeaningOut
//
//  Created by NERO on 6/23/24.
//

import UIKit
import WebKit
import SnapKit

final class ProductWebViewController: UIViewController {
    var selectedProductName: String = ""
    lazy var cleanedTitle = Meaning.Method.removeHTMLTags(text: selectedProductName)
    var productURL: String = ""
    
    private let webview = WKWebView()
    lazy var url = URL(string: productURL)
    lazy var request = URLRequest(url: url!)

    override func viewDidLoad() {
        super.viewDidLoad()
        webview.load(request)
        view.backgroundColor = Meaning.Color.background
        view.addSubview(webview)
        webview.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingNavigation(title: cleanedTitle, rightBarItem: nil)
    }
}
