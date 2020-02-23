//
//  OrderDetailFooterView.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

struct OrderDetailFooterViewModel {
    let orderDate: String
    let price: String
    
    init(orderDate: String, price: Int) {
        self.orderDate = orderDate
        self.price = L10n.orderPriceWithCurrency("\(price)")
    }
}

class OrderDetailFooterView: UIView {
    //MARK: - Public properties
    var viewModel: OrderDetailFooterViewModel? {
        didSet { bindViewModel() }
    }
    
    //MARK: - Private properties
    @IBOutlet private weak var orderDateLabel: UILabel!
    @IBOutlet private weak var priceContainerView: UIView!
    @IBOutlet private weak var priceLabel: UILabel!
    
    //MARK: - init
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
    
    //MARK: - Private methods, UI setup
    private func setupUI() {
        backgroundColor = Asset.Colors.background.color
        
        orderDateLabel.font = Font.italic(size: .large)
        
        priceLabel.font = Font.bold(size: .extraLarge)
        priceContainerView.decorator(with: [AppStyle.cornerRadius16Decorator, AppStyle.shadowDecorator])
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            fatalError("ViewModel is not set! - OrderDetailFooterView")
        }
        orderDateLabel.text = viewModel.orderDate
        priceLabel.text = viewModel.price
    }
}
