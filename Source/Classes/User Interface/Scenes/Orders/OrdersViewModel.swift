//
//  OrdersViewModel.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Foundation
import RxSwift

protocol OrdersViewModelFlowDelegate: class {
    func didTapOrder(on order: Order)
    func showLoadOrdersFailedAlert()
}

protocol OrdersViewModelInputs {
    func ordersVCViewDidLoad()
    func didSelectItem(at index: Int)
}

protocol OrdersViewModelOutputs {
    var items: [OrderCollectionCellViewModel] { get }
    var shouldReloadData: Observable<Void> { get }
    var moneySumViewModel: MoneySumViewModel? { get }
    var shouldShowMoneyBox: Observable<Bool> { get }
}

protocol OrdersViewModel: AnyObject {
    var inputs: OrdersViewModelInputs { get }
    var outputs: OrdersViewModelOutputs { get }
    var flowDelegate: OrdersViewModelFlowDelegate? { get set }
}

final class OrdersViewModelImpl: OrdersViewModel {
    //MARK: - Properties
    var inputs: OrdersViewModelInputs { return self }
    var outputs: OrdersViewModelOutputs { return self }
    weak var flowDelegate: OrdersViewModelFlowDelegate?
    
    var items: [OrderCollectionCellViewModel] = []
    var shouldReloadData: Observable<Void> {
        return _shouldReloadData.asObservable().skip(1).observeOn(MainScheduler.instance)
    }
    var shouldShowMoneyBox: Observable<Bool> {
        return _shouldShowMoneyBox.asObservable().observeOn(MainScheduler.instance)
    }
    var moneySumViewModel: MoneySumViewModel?
    
    //MARK: - Private properties
    private let _shouldReloadData: BehaviorSubject<Void> = BehaviorSubject<Void>(value: ())
    private let _shouldShowMoneyBox: PublishSubject<Bool> = PublishSubject<Bool>()
    private let orderService: OrderService
    private var orders: [Order] = []
    
    //MARK: - init
    init(orderService: OrderService) {
        self.orderService = orderService
    }
    
    /*  loading orders from the specific API
        sorting data in descending order by orderDate
        create OrderCollectionViewModels    */
    func ordersVCViewDidLoad() {
        var prices = 0
        orders = []
        orderService.loadOrders(succes: { [weak self] result in
            guard let self = self else { return }
            let orderCellViewModels = result.sorted { $0.date > $1.date }
                .map { (order: Order) -> OrderCollectionCellViewModel in
                    prices += order.price
                    self.orders.append(order)
                    let orderCellViewModel = OrderCollectionCellViewModelImpl(id: order.orderId, title: order.title, price: order.price, imageURL: order.imageUrls?.first)
                    return orderCellViewModel
                }
            self.items = orderCellViewModels
            self.moneySumViewModel = MoneySumViewModel(priceSum: L10n.orderPriceWithCurrency("\(prices)"))
            self._shouldReloadData.onNext(())
            self._shouldShowMoneyBox.onNext(true)
        }) { [weak self] _ in
            guard let self = self else { return }
            self.flowDelegate?.showLoadOrdersFailedAlert()
        }
    }
    
    
    func didSelectItem(at index: Int) {
        let selectedOrder = orders.first { $0.orderId == self.items[index].orderId }
        
        guard let order = selectedOrder else { return }
        flowDelegate?.didTapOrder(on: order)
    }
}

//MARK: - OrdersViewModelInputs, OrdersViewModelOutputs
extension OrdersViewModelImpl: OrdersViewModelInputs, OrdersViewModelOutputs {}
