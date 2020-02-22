//
//  RequestRepresentable.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Alamofire
import Foundation

protocol RequestRepresentable {
    var methodType: HTTPMethod { get }
    var suffix: String { get }
    var parameters: [String: Any]? { get }
    var encoding: URLEncoding { get }
}

extension RequestRepresentable {
    var parameters: [String: Any]? {
        return nil
    }
    
    var encoding: URLEncoding {
        switch methodType {
        case .get, .delete: return .queryString
        default: return .httpBody
        }
    }
}
