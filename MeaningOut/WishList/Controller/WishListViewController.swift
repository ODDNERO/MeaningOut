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
        settingNavigation(title: "WISH LIST", rightBarItem: makeMenuButton())
        settingDelegate()
        wishList = repository.readAllItem()
        wishListView.wishTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        wishListView.wishTableView.reloadData()
    }
}
extension WishListViewController {
    private func makeMenuButton() -> UIBarButtonItem {
        let bytitleAction = UIAction(title: "아이템 이름 정렬") { _ in
            self.wishList = self.wishList?.sorted(byKeyPath: "title", ascending: true)
        }
        let byDeadlineAction = UIAction(title: "위시 날짜 정렬") { _ in
            self.wishList = self.wishList?.sorted(byKeyPath: "wishDate", ascending: false)
        }
        let menu = UIMenu(children: [bytitleAction, byDeadlineAction])
        let menuButton = UIBarButtonItem(title: nil, image: Meaning.Image.down, target: nil, action: nil, menu: menu)
        menuButton.tintColor = .black
        return menuButton
    }
    
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
        cell.wishButton.tag = indexPath.row
        cell.wishButton.addTarget(self, action: #selector(wishButtonClicked), for: .touchUpInside)
        return cell
    }
    @objc func wishButtonClicked(_ sender: UIButton) {
        let indexPath = IndexPath(item: sender.tag, section: 0)
        if let cell = wishListView.wishTableView.cellForRow(at: indexPath) as? WishListTableViewCell {
            guard let selectedItemProductID = self.wishList?[indexPath.row].productID else { return }
            
            let deleteAction = UIAction(title: "위시에서 빼기", attributes: .destructive, handler: { _ in
                self.repository.deleteItem(selectedItemProductID)
                self.wishListView.wishTableView.reloadData()
                print(self.repository.readAllItem())
            })
            cell.wishButton.menu = UIMenu(children: [deleteAction])
            cell.wishButton.showsMenuAsPrimaryAction = true
        }
//        showAlert(title: "위시에서 삭제할까요?", message: "", okText: "삭제") {
//            if let cell = self.wishListView.wishTableView.cellForRow(at: indexPath) as? WishListTableViewCell {
//                cell.configureWishButtonUI(false)
//                guard let selectedItemProductID = self.wishList?[indexPath.row].productID else { return }
//                self.repository.deleteItem(selectedItemProductID)
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productWebVC = ProductWebViewController()
        productWebVC.selectedProductName = wishList?[indexPath.row].title ?? ""
        guard let link = wishList?[indexPath.row].link else { return }
        productWebVC.productURL = link
        navigationController?.pushViewController(productWebVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
