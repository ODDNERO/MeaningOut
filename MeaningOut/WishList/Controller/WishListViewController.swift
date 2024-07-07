//
//  WishListViewController.swift
//  MeaningOut
//
//  Created by NERO on 7/5/24.
//

import UIKit
import RealmSwift

final class WishListViewController: UIViewController {
    private let wishListView = WishListView()
    
    private let repository = WishItemRepository()
    private var wishList: Results<WishItem>? {
        didSet {
            wishListView.wishTableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = wishListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingDelegate()
        wishList = repository.readAllItem()
        wishListView.wishTableView.reloadData()
    }
}
extension WishListViewController {
    private func settingDelegate() {
        wishListView.wishTableView.delegate = self
        wishListView.wishTableView.dataSource = self
        wishListView.wishTableView.register(WishListTableViewCell.self, forCellReuseIdentifier: WishListTableViewCell.identifier)
        wishListView.searchTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    @objc private func textFieldEditingChanged() {
        guard let searchText = wishListView.searchTextField.text else { return }
        wishList = repository.filterSearchTitleItem(searchText)
    }
}

extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.identifier) as! WishListTableViewCell
        if let item = wishList?[indexPath.row] { cell.update(data: item) }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
