//
//  WishItemRepository.swift
//  MeaningOut
//
//  Created by NERO on 7/5/24.
//

import Foundation
import RealmSwift

final class WishItemRepository {
    private let realm = try! Realm()
    
    func createItem(_ data: WishItem) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Create Error: \(error)")
        }
    }
    
    func readAllItem() -> Results<WishItem> {
        return realm.objects(WishItem.self).sorted(byKeyPath: "wishDate", ascending: true)
    }
    
    func updateItem<T>(_ data: WishItem, coulmn: String, value: T) {
        realm.create(WishItem.self, value: ["id": data.id, coulmn: value], update: .modified)
    }
    
    func updateAllItem<T>(coulmn: String, value: T) {
        let result = realm.objects(WishItem.self)
        try! realm.write {
            result.setValue(value, forKey: coulmn)
        }
    }
    
    func deleteItem(_ deleteItemProductID: String) {
        let filter = realm.objects(WishItem.self).where {
            $0.productID.contains(deleteItemProductID)
        }
        guard let item = filter.first else { return }
        
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Delete Error: \(error)")
        }
    }
    
    func filterSearchTitleItem(column: String, searchText: String) -> Results<WishItem> {
        let filter = realm.objects(WishItem.self).where {
            $0.title.contains(searchText)
        }
        let result = searchText.isEmpty ? realm.objects(WishItem.self) : filter
        return result
    }
    
    func isItemInWishlist(findProductID: String) -> Bool {
        let WishItemList = realm.objects(WishItem.self)
        var isFind = false
        WishItemList.forEach {
            if $0.productID == findProductID { isFind = true }
        }
        return isFind
    }
}
