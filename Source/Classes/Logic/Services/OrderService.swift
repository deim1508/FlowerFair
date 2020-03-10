//
//  OrderService.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Foundation

protocol OrderService {
    func loadOrders(succes: @escaping([Order]) -> Void, failure: @escaping(Error) -> Void)
}

class OrderServiceImpl: OrderService {
    func loadOrders(succes: @escaping ([Order]) -> Void, failure: @escaping (Error) -> Void) {
        BackendManager.execute(request: OrderRequest(), succes: succes, failure: failure)
    }
}
