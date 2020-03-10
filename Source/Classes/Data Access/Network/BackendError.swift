//
//  BackendError.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case invalidJSON
    case invalidURL
    case invalidData
    case generalError
    
    var message: String {
        switch self {
        case .invalidJSON: return L10n.invalidJson
        case .invalidURL: return L10n.invalidUrl
        case .invalidData: return L10n.invalidData
        case .generalError: return L10n.generalError
        }
    }
}
