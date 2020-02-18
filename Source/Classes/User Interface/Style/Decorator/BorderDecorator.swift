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
        view.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    func removeDecorator(view: UIView) {
        view.layer.borderWidth = 0
    }
}
