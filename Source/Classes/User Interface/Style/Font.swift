//
//  Font.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    /// 10
    case extraSmall     = 10
    /// 12
    case small          = 12
    /// 14
    case mediumSmall    = 14
    /// 16
    case medium         = 16
    /// 18
    case mediumLarge    = 18
    /// 20
    case midLarge       = 20
    /// 24
    case large          = 24
    /// 32
    case extraLarge     = 32
    /// 40
    case superLarge     = 40
}

struct Font {
    static func regular(size: FontSize) -> UIFont {
        return UIFont(name: "BodoniSvtyTwoITCTT-Book", size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }
    
    static func italic(size: FontSize) -> UIFont {
        return UIFont(name: "BodoniSvtyTwoITCTT-BookIta", size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue, weight: .medium)
    }
    
    static func bold(size: FontSize) -> UIFont {
        return UIFont(name: "BodoniSvtyTwoITCTT-Bold", size: size.rawValue) ?? UIFont.boldSystemFont(ofSize: size.rawValue)
    }
}

protocol FontConvertible {
    func font(size: FontSize) -> UIFont!
}

extension FontConvertible where Self: RawRepresentable, Self.RawValue == String {
    
    func font(size: FontSize) -> UIFont! {
        return UIFont(name: self.rawValue, size: size.rawValue)
    }
}
