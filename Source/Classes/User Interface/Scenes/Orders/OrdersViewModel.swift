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
    func didSelectItem(at index: Int, isFiltered: Bool)
    func didPullToRefresh(completion: @escaping () -> Void)
    func filterContentForSearchText(_ searchText: String)
}

protocol OrdersViewModelOutputs {
    var items: [OrderCollectionCellViewModel] { get }
    var filteredItems: [OrderCollectionCellViewModel] { get }
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
    var filteredItems: [OrderCollectionCellViewModel] = []
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
    
    func ordersVCViewDidLoad() {
       loadOrders()
    }
    
    func didSelectItem(at index: Int, isFiltered: Bool) {
        let selectedOrderItem = isFiltered ? filteredItems[index] : items[index]
        let selectedOrder = orders.first { $0.orderId == selectedOrderItem.orderId }
        
        guard let order = selectedOrder else { return }
        flowDelegate?.didTapOrder(on: order)
    }
    
    func didPullToRefresh(completion: @escaping () -> Void) {
        loadOrders { completion() }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        //get orders which contains the searched Text in Title, Price, DeliverTo or in Description
        let filteredOrders = orders.filter { "\($0.title.lowercased())\($0.price)\($0.deliverTo.lowercased())\(String(describing: $0.description).lowercased())".contains(searchText.lowercased()) }
        
        //get the filtered orderCellViewModels
        filteredItems = items.filter { item in filteredOrders.contains { order -> Bool in
            order.orderId == item.orderId
        }}
        _shouldReloadData.onNext(())
    }
    
    /*  loading orders from the specific API
    sorting data in descending order by orderDate
    create OrderCollectionViewModels    */
    private func loadOrders(completion: @escaping () -> Void = {}) {
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
            completion()
       }) { [weak self] _ in
           guard let self = self else { return }
           self.flowDelegate?.showLoadOrdersFailedAlert()
       }
    }
}

//MARK: - OrdersViewModelInputs, OrdersViewModelOutputs
extension OrdersViewModelImpl: OrdersViewModelInputs, OrdersViewModelOutputs {}
