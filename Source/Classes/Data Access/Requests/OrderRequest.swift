//
//  OrderRequest.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Alamofire
import Foundation

class OrderRequest: RequestRepresentable {
    var methodType: HTTPMethod
    var suffix: String
    var parameters: [String : Any]?
    
    init() {
        methodType = .get
        suffix = NetworkConstans.APISuffix.order
    }
}
