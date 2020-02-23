//
//  Order.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Foundation

struct Order: Codable {
    let orderId: Int
    let title: String
    let description: String?
    let price: Int
    let deliverTo: String
    let imageUrls: [String]?
    let date: Int
}

extension Order {
    enum CodingKeys: String, CodingKey {
        case orderId = "id"
        case title
        case description
        case price
        case deliverTo = "deliver_to"
        case imageUrls = "image_urls"
        case date
    }
}
