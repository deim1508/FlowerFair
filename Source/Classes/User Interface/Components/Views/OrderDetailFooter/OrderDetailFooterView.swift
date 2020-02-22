//
//  OrderDetailFooterView.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

struct OrderDetailFooterViewModel {
    let deliverToName: String
    let price: String
    
    init(deliverTo: String, price: Int) {
        deliverToName = deliverTo
        self.price = "\(price) RON"
    }
}

class OrderDetailFooterView: UIView {
    //MARK: - Public properties
    var viewModel: OrderDetailFooterViewModel? {
        didSet { bindViewModel() }
    }
    
    //MARK: - Private properties
    @IBOutlet private weak var deliverToNameLabel: UILabel!
    @IBOutlet private weak var deliverToLabel: UILabel!
    @IBOutlet private weak var priceContainerView: UIView!
    @IBOutlet private weak var priceLabel: UILabel!
    
    //MARK: - UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        loadXib()
        backgroundColor = Asset.Colors.background.color
        
        deliverToLabel.text = L10n.deliverTo
        deliverToLabel.font = Font.regular(size: .large)
        
        deliverToNameLabel.font = Font.regular(size: .extraLarge)
        
        priceLabel.font = Font.bold(size: .extraLarge)
        
        priceContainerView.decorator(with: [AppStyle.cornerRadius16Decorator, AppStyle.shadowDecorator])
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            fatalError("ViewModel is not set! - OrderDetailFooterView")
        }
        deliverToNameLabel.text = viewModel.deliverToName
        priceLabel.text = viewModel.price
    }
}
