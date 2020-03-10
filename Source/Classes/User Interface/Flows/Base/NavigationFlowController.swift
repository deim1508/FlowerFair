//
//  NavigationFlowController.swift
//  FlowerFair
//
//  Created by babycougar on 2/17/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

class NavigationFlowController: FlowController {
    fileprivate (set) var flowPresentation: FlowControllerPresentation
    fileprivate (set) var parentFlow: FlowController?
    
    private (set) var navigationController: UINavigationController?
    var mainViewController: UIViewController? {
        return navigationController
    }
    
    //MARK: - Lifecycle
    required init(from parent: FlowController?, for presentation: FlowControllerPresentation) {
        parentFlow = parent
        flowPresentation = presentation
    }
    
    //MARK: - Flow cycle
    func initMainViewController() {
        guard navigationController == nil else { return }
        
        if let parentFlow = parentFlow {
            if flowPresentation == .present {
                let root = firstScreen()
                navigationController = UINavigationController(rootViewController: root)
            } else if flowPresentation == .push {
                if let parentNavFlow = parentFlow as? NavigationFlowController {
                    navigationController = parentNavFlow.navigationController
                } else {
                    assertionFailure("Parent flow need to be a navigation flow for a push presentation!")
                }
            }
        } else {
            if flowPresentation == .push {
                assertionFailure("Need to have a parent flow for a push presentation!")
            } else {
            let root = firstScreen()
            navigationController = UINavigationController(rootViewController: root)
            }
        }
    }
    
    func firstScreen() -> UIViewController {
        return UIViewController()
    }
    

}
