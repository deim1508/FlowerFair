//
//  ImageCollectionViewCell.swift
//  FlowerFair
//
//  Created by Rebeka on 23/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit
import PINRemoteImage

struct ImageCollectionViewCellViewModel {
    let flowerImageUrl: URL?
    
    init(flowerImageUrl: String) {
        self.flowerImageUrl = URL(string: flowerImageUrl)
    }
}

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var flowerImageView: UIImageView!
    
    var viewModel: ImageCollectionViewCellViewModel? {
        didSet { bindViewModel() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        flowerImageView.pin_cancelImageDownload()
    }
    
    private func bindViewModel() {
        flowerImageView.pin_setImage(from: viewModel?.flowerImageUrl, placeholderImage: Asset.Images.orderPlaceholder1.image)
    }
}
