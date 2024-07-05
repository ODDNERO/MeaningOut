//
//  WishItem.swift
//  MeaningOut
//
//  Created by NERO on 7/5/24.
//

import Foundation
import RealmSwift

class WishItem: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var productID: String
    @Persisted(indexed: true) var title: String
    @Persisted var imageString: String
    @Persisted var price: String
    @Persisted var mallName: String
    @Persisted var link: String
    @Persisted var wishDate: String
    
    convenience init(productID: String, title: String, imageString: String, price: String, mallName: String, link: String, wishDate: String) {
        self.init()
        self.productID = productID
        self.title = title
        self.imageString = imageString
        self.price = price
        self.mallName = mallName
        self.link = link
        self.wishDate = wishDate
    }
}
