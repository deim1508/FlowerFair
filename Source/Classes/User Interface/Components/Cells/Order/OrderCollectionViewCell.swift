//
//  OrderCollectionViewCell.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {

    //MARK: - Private properties
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: - Lifecycle method
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.image = Asset.Images.orderPlaceholder1.image
        titleLabel.text = "Flower Fair"
        titleLabel.font = Font.regular(size: .large)
        contentView.decorator(with: [AppStyle.borderDecorator, AppStyle.cornerRadiusDecorator])
        
    }

}
