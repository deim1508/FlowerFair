//
//  BorderDecorator.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit.UIView

struct BorderDecorator: ViewDecorator {
    func decorate(view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = Asset.Colors.shadow.color
    }
    
    func removeDecorator(view: UIView) {
        view.layer.borderWidth = 0
    }
}
