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
        self.price = L10n.orderPriceWithCurrency("\(price)")
    }
}

class OrderDetailFooterView: UIView {
    //MARK: - Public properties
    var viewModel: OrderDetailFooterViewModel? {
        didSet { bindViewModel() }
    }
    
    //MARK: - Private properties
    @IBOutlet private weak var orderDataLabel: UILabel!
    @IBOutlet private weak var priceContainerView: UIView!
    @IBOutlet private weak var priceLabel: UILabel!
    
    //MARK: - UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        setupUI()
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
        setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        backgroundColor = Asset.Colors.background.color
        
        orderDataLabel.font = Font.italic(size: .large)
        
        priceLabel.font = Font.bold(size: .extraLarge)
        priceContainerView.decorator(with: [AppStyle.cornerRadius16Decorator, AppStyle.shadowDecorator])
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            fatalError("ViewModel is not set! - OrderDetailFooterView")
        }
        orderDataLabel.text = "22.02.2020"
        priceLabel.text = viewModel.price
    }
}
