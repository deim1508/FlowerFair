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
    var orderImageUrls: [URL?] { get }
    var footerViewModel: OrderDetailFooterViewModel { get }
    var orderTitle: String { get }
    var orderDescription: String? { get }
    var deliverTo: String { get }
}

protocol OrderDetailViewModel {
    var inputs: OrderDetailViewModelInputs { get }
    var outputs: OrderDetailViewModelOutputs { get }
}

final class OrderDetailViewModelImpl: OrderDetailViewModel {
    //MARK: - Public properties
    var inputs: OrderDetailViewModelInputs { return self }
    var outputs: OrderDetailViewModelOutputs { return self }
    var orderImageUrls: [URL?] = []
    var footerViewModel: OrderDetailFooterViewModel
    var orderTitle: String
    var orderDescription: String?
    var deliverTo: String
    
    //MARK: - Private properties
    private let order: Order
    
    //MARK: - init
    init(order: Order) {
        self.order = order
        footerViewModel = OrderDetailFooterViewModel(deliverTo: order.deliverTo, price: order.price)
        orderTitle = order.title
        orderDescription = order.description
        deliverTo = "\(L10n.deliveredTo)  \(order.deliverTo)"
        
        guard let imageUrls = order.imageUrl else { return }
        orderImageUrls = imageUrls.map({ imageUrl -> URL? in
            URL(string: imageUrl)
        })
    }
}

//MARK: - OrderDetailViewModelInputs, OrderDetailViewModelOutputs
extension OrderDetailViewModelImpl: OrderDetailViewModelInputs, OrderDetailViewModelOutputs {}
