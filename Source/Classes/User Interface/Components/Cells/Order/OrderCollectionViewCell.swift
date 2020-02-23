//
//  OrderCollectionViewCell.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit
import PINRemoteImage

struct OrderCollectionViewCellViewModel {
    let orderId: Int
    let title: String
    let price: String
    var imageURL: URL?
    
    init(id: Int, title: String, price: Int, imageURL: String?) {
        orderId = id
        self.title = title
        self.price = "\(price) RON"
        self.imageURL = nil
        if let imageURL = imageURL {
            self.imageURL = URL(string: imageURL)
        }
    }
}

class OrderCollectionViewCell: UICollectionViewCell {

    //MARK: - Private properties
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    //MARK: - Public properties
    var viewModel: OrderCollectionViewCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    //MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
