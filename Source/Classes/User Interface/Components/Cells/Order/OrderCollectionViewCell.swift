//
//  OrderCollectionViewCell.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit
import PINRemoteImage

class OrderCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Public properties
    var viewModel: OrderCollectionCellViewModel? {
        didSet { bindViewModel() }
    }
    
    //MARK: - Private properties
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    //MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        decorator(with: [AppStyle.cornerRadiusDecorator, AppStyle.shadowDecorator])
        
        imageView.clipsToBounds = true
        
        contentView.decorator(with: AppStyle.cornerRadiusDecorator)
        contentView.backgroundColor = Asset.Colors.orderCellBackground.color
                
        titleLabel.textAlignment = .right
        titleLabel.font = Font.regular(size: .mediumLarge)
        
        priceLabel.textAlignment = .right
        priceLabel.font = Font.bold(size: .midLarge)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.pin_cancelImageDownload()
    }
    
    //MARK: - Private methods
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            fatalError("ViewModel is not set! - OrderCollectionViewCell")
        }
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        imageView.pin_setImage(from: viewModel.imageURL, placeholderImage: Asset.Images.orderPlaceholder.image)
    }
}
