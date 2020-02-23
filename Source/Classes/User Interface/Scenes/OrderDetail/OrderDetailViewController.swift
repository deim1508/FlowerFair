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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: ISPageControl!
    @IBOutlet private weak var footerView: OrderDetailFooterView!
    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerWithNib(cellType: ImageCollectionViewCell.self)
        collectionView.backgroundColor = .red
        
        pageControl.numberOfPages = viewModel.outputs.imageCollectionCellViewModels.count
        pageControl.backgroundColor = Asset.Colors.background.color
    }
}

//MARK: - UIScrollViewDelegate
extension OrderDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}

extension OrderDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputs.imageCollectionCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ImageCollectionViewCell.self)
        cell.viewModel = viewModel.outputs.imageCollectionCellViewModels[indexPath.row]
        return cell
    }
}

extension OrderDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
    }
}

//MARK: - BindableType
extension OrderDetailViewController: BindableType {
    func bindViewModel() {}
}
