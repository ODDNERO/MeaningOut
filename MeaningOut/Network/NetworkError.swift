//
//  NetworkError.swift
//  MeaningOut
//
//  Created by NERO on 6/29/24.
//

import Foundation

enum NetworkError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}
