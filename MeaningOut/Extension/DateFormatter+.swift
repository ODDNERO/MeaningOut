//
//  DateFormatter+.swift
//  MeaningOut
//
//  Created by NERO on 7/6/24.
//

import Foundation

extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd(EEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
