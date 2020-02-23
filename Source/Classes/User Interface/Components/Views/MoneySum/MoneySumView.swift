//
//  MoneySumView.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

struct MoneySumViewModel {
    let priceSum: String
    
    init(priceSum: Int) {
        self.priceSum = "\(priceSum) RON"
    }
}

class MoneySumView: UIView {
    //MARK: - Private properties
    private let moneyBoxImageView = UIImageView.autoLayout()
    private let moneySumLabel = UILabel.autoLayout()
    private let stackView = UIStackView.autoLayout()
    
    var viewModel: MoneySumViewModel? {
        didSet { bindViewModel() }
    }
    
    //MARK: - UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 6
        
        moneyBoxImageView.image = Asset.Images.iconMoneyBox.image
        moneyBoxImageView.tintColor = .black
        stackView.addArrangedSubview(moneyBoxImageView)
        
        moneySumLabel.font = Font.regular(size: .medium)
        moneySumLabel.textAlignment = .left
        stackView.addArrangedSubview(moneySumLabel)
        
        addSubview(stackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func bindViewModel() {
        moneySumLabel.text = viewModel?.priceSum
    }
}
