//
//  OrderDetailViewController.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import ISPageControl
import UIKit
import PINRemoteImage

class OrderDetailViewController: UIViewController {
    //MARK: - Private properties    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: ISPageControl!
    @IBOutlet private weak var footerView: OrderDetailFooterView!
    @IBOutlet private weak var orderTitleLabel: UILabel!
    @IBOutlet private weak var deliverToLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    private var frame = CGRect.zero
    
    //MARK: - Public properties
    var viewModel: OrderDetailViewModel!
    
    //MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = Asset.Colors.background.color
        footerView.viewModel = viewModel.outputs.footerViewModel
        scrollView.delegate = self
        
        pageControl.numberOfPages = viewModel.outputs.orderImageUrls.count
        pageControl.backgroundColor = Asset.Colors.background.color
        
        setupScrollView()
        
        
        orderTitleLabel.font = Font.regular(size: .large)
        orderTitleLabel.text = viewModel.outputs.orderTitle
        
        deliverToLabel.font = Font.regular(size: .midLarge)
        deliverToLabel.text = viewModel.outputs.deliverTo
        
        descriptionTextView.font = Font.regular(size: .mediumLarge)
        descriptionTextView.text = viewModel.outputs.orderDescription
        descriptionTextView.isEditable = false
        descriptionTextView.showsVerticalScrollIndicator = false
    }
    
    private func setupScrollView() {
        guard !viewModel.outputs.orderImageUrls.isEmpty else {
            setupScrollViewWithPlaceholder()
            return
        }
        
        for (index, imageUrl) in viewModel.outputs.orderImageUrls.enumerated() {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let orderImageView = UIImageView(frame: frame)
            orderImageView.contentMode = .scaleAspectFill
            orderImageView.pin_setImage(from: imageUrl, placeholderImage: Asset.Images.orderPlaceholder.image)

            self.scrollView.addSubview(orderImageView)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(viewModel.outputs.orderImageUrls.count)), height: 0)
    }
    
    private func setupScrollViewWithPlaceholder() {
        let placeholderImageView = UIImageView.autoLayout()
        placeholderImageView.image = Asset.Images.orderPlaceholder.image
        placeholderImageView.contentMode = .scaleAspectFill
        
        scrollView.addSubview(placeholderImageView)
        
        NSLayoutConstraint.activate([
            placeholderImageView.topAnchor.constraint(equalTo: view.topAnchor),
            placeholderImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeholderImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeholderImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: 0)
    }
}

//MARK: - UIScrollViewDelegate
extension OrderDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}

//MARK: - BindableType
extension OrderDetailViewController: BindableType {
    func bindViewModel() {}
}
