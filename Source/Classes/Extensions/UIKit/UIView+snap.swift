//
//  UIView+snap.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit.UIView

public protocol AutoLayout {
    static func autoLayout() -> Self
}

public extension AutoLayout where Self: UIView {
    static func autoLayout() -> Self {
        let view = Self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension UIView: AutoLayout {}

extension UIView {
    func snap(into view: UIView, insets: UIEdgeInsets = .zero, priority: UILayoutPriority = .required) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right)
        ]
        constraints.forEach { $0.priority = priority }
        NSLayoutConstraint.activate(constraints)
    }

    func snapToSafeArea(into view: UIView) {
        let constraints: [NSLayoutConstraint] = [
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
