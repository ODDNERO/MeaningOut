//
//  DateFormatter+.swift
//  MeaningOut
//
//  Created by NERO on 7/6/24.
//

import Foundation

extension DateFormatter {
    static let wishDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "✨ yy.MM.dd [EEE] HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static let wishTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ss"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
