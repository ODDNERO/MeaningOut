//
//  ProductDTO.swift
//  MeaningOut
//
//  Created by NERO on 6/23/24.
//

import Foundation

struct ProductDTO: Decodable {
    let total, start, display: Int
    let items: [Item]
}

struct Item: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
}
