//
//  MainFlowController.swift
//  FlowerFair
//
//  Created by babycougar on 2/17/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

class MainFlowController: FlowController {
    private var ordersController: OrdersViewController!
    private var navigationController: UINavigationController!
    
    var mainViewController: UIViewController? {
        navigationController = UINavigationController(rootViewController: ordersController)
        return navigationController
    }
    
    var flowPresentation: FlowControllerPresentation
    var parentFlow: FlowController?
    
    required init(from parent: FlowController? = nil, for presentation: FlowControllerPresentation = .custom) {
        parentFlow = parent
        flowPresentation = presentation
    }
    
    func initMainViewController() {
        let orderService = OrderServiceImpl()
        ordersController = StoryboardScene.OrdersViewController.initialScene.instantiate()
        let ordersViewModel = OrdersViewModelImpl(orderService: orderService)
        ordersViewModel.flowDelegate = self
        ordersController.bind(viewModel: ordersViewModel)
    }
    
    func firstScreen() -> UIViewController {
        return ordersController
    }
}

//MARK: - OrdersViewModelFlowDelegate
extension MainFlowController: OrdersViewModelFlowDelegate {
    func didTapOrder(on order: Order) {
        let orderDetailVC = StoryboardScene.OrderDetailViewController.initialScene.instantiate()
        orderDetailVC.bind(viewModel: OrderDetailViewModelImpl(order: order))
        navigationController.pushViewController(orderDetailVC, animated: true)
    }
}
