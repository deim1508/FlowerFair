//
//  OrdersViewModel.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Foundation
import RxSwift

protocol OrdersViewModelInputs {
    func ordersVCViewDidLoad()
}

protocol OrdersViewModelOutputs {
    var items: [OrderCollectionViewCellViewModel] { get }
    var shouldReloadData: Observable<Void> { get }
}

protocol OrdersViewModel {
    var inputs: OrdersViewModelInputs { get }
    var outputs: OrdersViewModelOutputs { get }
}

final class OrdersViewModelImpl: OrdersViewModel {
    //MARK: - Properties
    var inputs: OrdersViewModelInputs { return self }
    var outputs: OrdersViewModelOutputs { return self }
    
    var items: [OrderCollectionViewCellViewModel] = []
    var shouldReloadData: Observable<Void> {
        return _shouldReloadData.asObservable().skip(1).observeOn(MainScheduler.instance)
    }
    //MARK: - Private properties
    private let _shouldReloadData: BehaviorSubject<Void> = BehaviorSubject<Void>(value: ())
    private let orderService: OrderService
    
    init(orderService: OrderService) {
        self.orderService = orderService
    }
    
    func ordersVCViewDidLoad() {
        orderService.loadOrders(succes: { [weak self] result in
            guard let self = self else { return }
            let orders = result.map { (order: Order) -> OrderCollectionViewCellViewModel in
                return OrderCollectionViewCellViewModel(title: order.title, price: order.price, imageURL: order.imageUrl)
            }
            self.items = orders
            self._shouldReloadData.onNext(())
        }) { error in
            print(error)
        }
    }
}

//MARK: - OrdersViewModelInputs, OrdersViewModelOutputs
extension OrdersViewModelImpl: OrdersViewModelInputs, OrdersViewModelOutputs {}
