//
//  OrderDetailViewController.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit
import PINRemoteImage

class OrderDetailViewController: UIViewController {
    //MARK: - Private properties
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var footerView: OrderDetailFooterView!
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
        
        containerView.backgroundColor = .blue
        pageControl.numberOfPages = viewModel.outputs.flowerImageUrls.count
        pageControl.backgroundColor = .red
        setupPageControl()
        scrollView.delegate = self
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        footerView.viewModel = viewModel.outputs.footerViewModel
    }
    
    private func setupPageControl() {
        for (index, imageUrl) in viewModel.outputs.flowerImageUrls.enumerated() {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imageView = UIImageView(frame: frame)
            imageView.pin_setImage(from: imageUrl, placeholderImage: Asset.Images.orderPlaceholder1.image)
            
            self.scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(viewModel.outputs.flowerImageUrls.count)), height: scrollView.frame.size.height)
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
