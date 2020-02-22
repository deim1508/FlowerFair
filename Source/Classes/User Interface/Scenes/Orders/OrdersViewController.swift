//
//  OrdersViewController.swift
//  FlowerFair
//
//  Created by babycougar on 2/17/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit
import RxSwift

private enum LayoutValues {
    static let sectionInsets = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
}

class OrdersViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    private let disposeBag = DisposeBag()

    //MARK: - Public properties
    var viewModel: OrdersViewModel!
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.inputs.ordersVCViewDidLoad()
    }
    
    //MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = Asset.Colors.background.color
        title = L10n.orderListTitle
        
        collectionView.backgroundColor = Asset.Colors.background.color
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerWithNib(cellType: OrderCollectionViewCell.self)
    }
}

//MARK: - UICollectionViewDelegate
extension OrdersViewController: UICollectionViewDelegate {
   
}

//MARK: - UICollectionViewDatasource
extension OrdersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputs.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: OrderCollectionViewCell.self)
        cell.viewModel = viewModel.outputs.items[indexPath.row]
        cell.decorator(with: [AppStyle.cornerRadiusDecorator, AppStyle.shadowDecorator])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OrdersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return LayoutValues.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = LayoutValues.sectionInsets.left + LayoutValues.sectionInsets.right
         let size: CGFloat = (collectionView.frame.size.width / 2.0 ) - space
         return CGSize(width: size, height: size + 50)
     }
}

//MARK: - Bind viewModel
extension OrdersViewController: BindableType {
    func bindViewModel() {
        viewModel.outputs.shouldReloadData.bind { [unowned self] _ in
            self.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
}
