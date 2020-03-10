//
//  NetworkConstans.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Foundation

struct NetworkConstans {
    struct ProductionServer {
        static let baseURL = "http://demo1674266.mockable.io/"
    }
    
    struct APISuffix {
        static let order = "orders"
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}
