//
//  ldentifierProtocol.swift
//  MeaningOut
//
//  Created by NERO on 6/16/24.
//

import UIKit

protocol IdentifierProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
