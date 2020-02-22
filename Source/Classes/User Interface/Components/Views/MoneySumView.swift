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
        backgroundColor = .red
        stackView.axis = .horizontal
        stackView.alignment = .trailing
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
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//            moneyBoxImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            moneyBoxImageView.heightAnchor.constraint(equalTo: moneyBoxImageView.widthAnchor),
//            moneyBoxImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//
//            moneySumLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
//            moneySumLabel.centerYAnchor.constraint(equalTo: moneyBoxImageView.centerYAnchor),
//            moneySumLabel.leadingAnchor.constraint(equalTo: moneyBoxImageView.trailingAnchor, constant: 4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func bindViewModel() {
        moneySumLabel.text = viewModel?.priceSum
    }
}
