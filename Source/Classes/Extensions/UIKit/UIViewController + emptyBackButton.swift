//
//  UIViewController + emptyBackButton.swift
//  FlowerFair
//
//  Created by Rebeka on 23/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

extension UIViewController {
    open override func awakeFromNib() {
        super.awakeFromNib()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
