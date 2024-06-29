//
//  Error.swift
//  MeaningOut
//
//  Created by NERO on 6/29/24.
//

import Foundation

enum InputValidation: Error {
    case emptyText
    case invalidSpecialCharacter
    case invalidInt
    case InvalidLength
}
