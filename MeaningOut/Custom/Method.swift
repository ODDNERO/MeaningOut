//
//  Method.swift
//  MeaningOut
//
//  Created by NERO on 6/23/24.
//

import Foundation

extension Meaning {
    enum Method {
        static func formatNumber(_ number: Int) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: number))!
        }
        
        static func removeHTMLTags(text: String) -> String {
            var firstRemoved = text.replacingOccurrences(of: "<b>", with: "")
            let secondRemoved = firstRemoved.replacingOccurrences(of: "</b>", with: "")
            return secondRemoved
        }
    }
}
