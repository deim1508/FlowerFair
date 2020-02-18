//
//  ViewDecorator.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit.UIView

protocol ViewDecorator {
    func decorate(view: UIView)
    func removeDecorator(view: UIView)
}

extension UIView {
    func decorator(with decorator: ViewDecorator) {
        decorator.decorate(view: self)
    }
    
    func decorator(with decorators: [ViewDecorator]) {
        decorators.forEach { decorator in
            decorator.decorate(view: self)
        }
    }
    
    func removeDecorator(decorator: ViewDecorator) {
        decorator.removeDecorator(view: self)
    }
}
