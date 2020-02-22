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
    
    var mainViewController: UIViewController? {
        return UINavigationController(rootViewController: ordersController)
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
        ordersController.bind(viewModel: ordersViewModel)
    }
    
    func firstScreen() -> UIViewController {
        return ordersController
    }
}
