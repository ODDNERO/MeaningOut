//
//  IdentifierProtocol.swift
//  MeaningOut
//
//  Created by NERO on 6/16/24.
//

import UIKit

protocol IdentifierProtocol: AnyObject {
    static var identifier: String { get }
}

extension UIView: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
