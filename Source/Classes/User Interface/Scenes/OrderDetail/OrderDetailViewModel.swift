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
    var flowerImageUrls: [String]? { get }
    var imageCollectionCellViewModels: [ImageCollectionViewCellViewModel] { get }
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
    var flowerImageUrls: [String]? = []
    var footerViewModel: OrderDetailFooterViewModel
    var imageCollectionCellViewModels: [ImageCollectionViewCellViewModel] = []
    
    //MARK: - Private properties
    private let order: Order
    
    //MARK: - init
    init(order: Order) {
        self.order = order
        footerViewModel = OrderDetailFooterViewModel(deliverTo: order.deliverTo, price: order.price)
        
        flowerImageUrls = order.imageUrl
        guard let imageUrls = order.imageUrl else { return }
        imageCollectionCellViewModels = imageUrls.map({ imageUrl -> ImageCollectionViewCellViewModel in
            ImageCollectionViewCellViewModel(flowerImageUrl: imageUrl)
        })
    }
}

//MARK: - OrderDetailViewModelInputs, OrderDetailViewModelOutputs
extension OrderDetailViewModelImpl: OrderDetailViewModelInputs, OrderDetailViewModelOutputs {}
