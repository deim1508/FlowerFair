//
//  OrderDetailViewModel.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

protocol OrderDetailViewModelInputs {}
protocol OrderDetailViewModelOutputs {
    var flowerImageUrls: [URL?] { get }
    var footerViewModel: OrderDetailFooterViewModel { get }
}
protocol OrderDetailViewModel {
    var inputs: OrderDetailViewModelInputs { get }
    var outputs: OrderDetailViewModelOutputs { get }
}

final class OrderDetailViewModelImpl: OrderDetailViewModel {
    //MARK: - Public properties
    var inputs: OrderDetailViewModelInputs { return self }
    var outputs: OrderDetailViewModelOutputs { return self }
    var flowerImageUrls: [URL?] = []
    var footerViewModel: OrderDetailFooterViewModel
    
    //MARK: - Private properties
    private let order: Order
    
    //MARK: - init
    init(order: Order) {
        self.order = order
        footerViewModel = OrderDetailFooterViewModel(deliverTo: order.deliverTo, price: order.price)
        guard let imageUrls = order.imageUrl else { return }
        flowerImageUrls = imageUrls.map({ flowerImageUrl -> URL? in
            URL(string: flowerImageUrl)
        })
    }
}

//MARK: - OrderDetailViewModelInputs, OrderDetailViewModelOutputs
extension OrderDetailViewModelImpl: OrderDetailViewModelInputs, OrderDetailViewModelOutputs {}
