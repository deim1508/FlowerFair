//
//  AppStyle.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

enum FontType {
    case regular, italic, bold
}

struct AppStyle {
    static let shadowDecorator = ShadowDecorator(radius: 12)
    static let cornerRadiusDecorator = CornerRadiusDecorator(radius: 12)
    static let cornerRadius16Decorator = CornerRadiusDecorator(radius: 16)
    static let borderDecorator = BorderDecorator()
    
    static func setupAppearance() {
        UINavigationBar.appearance().backgroundColor = Asset.Colors.background.color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: Font.regular(size: .mediumLarge)]
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.font: Font.regular(size: .superLarge)]
        UINavigationBar.appearance().tintColor = .black
    }
}
