//
//  OrderCollectionCellViewModel.swift
//  FlowerFair
//
//  Created by Rebeka on 23/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Foundation

protocol OrderCollectionCellViewModel {
    var orderId: Int { get }
    var title: String { get }
    var price: String { get }
    var imageURL: URL? { get }
}

final class OrderCollectionCellViewModelImpl: OrderCollectionCellViewModel {
    let orderId: Int
    let title: String
    let price: String
    var imageURL: URL?
    
    init(id: Int, title: String, price: Int, imageURL: String?) {
        orderId = id
        self.title = title
        self.price = L10n.orderPriceWithCurrency("\(price)")
        if let imageURL = imageURL {
            self.imageURL = URL(string: imageURL)
        }
    }
}
