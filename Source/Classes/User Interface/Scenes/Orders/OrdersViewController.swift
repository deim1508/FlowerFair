//
//  OrdersViewController.swift
//  FlowerFair
//
//  Created by babycougar on 2/17/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit

private enum LayoutValues {
    static let sectionInsets = UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20)
    static let estimatedSize = CGSize(width: 150, height: 200)
}

class OrdersViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    //MARK: - Public properties
    var viewModel: OrdersViewModel!
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = Asset.Colors.background.color
        title = L10n.orderListTitle
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerWithNib(cellType: OrderCollectionViewCell.self)

        collectionViewLayout.estimatedItemSize = LayoutValues.estimatedSize
        collectionViewLayout.itemSize = UICollectionViewFlowLayout.automaticSize
    }
}

//MARK: - UICollectionViewDelegate
extension OrdersViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDatasource
extension OrdersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: OrderCollectionViewCell.self)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OrdersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return LayoutValues.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = LayoutValues.sectionInsets.left + LayoutValues.sectionInsets.right + 12
         let size:CGFloat = (collectionView.frame.size.width / 2.0 ) - 2 * space
         return CGSize(width: size, height: size)
     }
}

//MARK: - Bind viewModel
extension OrdersViewController: BindableType {
    func bindViewModel() {
        
    }
}
