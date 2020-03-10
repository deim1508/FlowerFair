//
//  RootFlowController.swift
//  FlowerFair
//
//  Created by babycougar on 2/17/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

class RootFlowController {
    private weak var window: UIWindow?
    
    private var activeFlow: FlowController?
    private var mainFlow: MainFlowController?
    
    fileprivate var root: UIViewController? {
        return window?.rootViewController
    }
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        startMainFlow(animated: true)
    }
    
    private func startMainFlow(animated: Bool) {
        if mainFlow == nil {
            let mainFlow = MainFlowController()
            show(flow: mainFlow, animated: animated)
            self.mainFlow = mainFlow
        }
    }
    
    private func setRoot(to viewController: UIViewController?, animated: Bool = false) {
        guard let viewController = viewController else { return }
        
        guard root != viewController else { return }
        
        func changeRoot(to viewController: UIViewController) {
            window?.rootViewController = viewController
        }
        
        if animated, let snapshotView = window?.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshotView)
            
            changeRoot(to: viewController)
            
            UIView.animate(withDuration: 0.33, animations: {
                snapshotView.alpha = 0.0
            }, completion: { _ in
                snapshotView.removeFromSuperview()
            })
        } else {
            changeRoot(to: viewController)
        }
    }
    
    private func show(flow: FlowController, animated: Bool = true) {
        activeFlow = flow
        flow.start { flowMainController in
            self.setRoot(to: flowMainController, animated: animated)
        }
    }
}
