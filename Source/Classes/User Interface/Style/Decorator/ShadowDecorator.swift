//
//  ShadowDecorator.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

struct ShadowDecorator: ViewDecorator {
    let radius: CGFloat
    let opacity: Float
      
    init(radius: CGFloat, opacity: Float = 1.0) {
        self.radius = radius
        self.opacity = opacity
    }
      
    func decorate(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = Asset.Colors.shadow.color.withAlphaComponent(0.17).cgColor
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = opacity
    }
      
    func removeDecorator(view: UIView) {
        view.layer.shadowRadius = 0
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
