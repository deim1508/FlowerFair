//
//  CornerRadiusDecorator.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit.UIView

struct CornerRadiusDecorator: ViewDecorator {
    let radius: CGFloat
    
    func decorate(view: UIView) {
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    
    func removeDecorator(view: UIView) {
        view.layer.cornerRadius = 0
    }
}
