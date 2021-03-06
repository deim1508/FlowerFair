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
    //MARK: - Public properties
    var viewModel: OrdersViewModel!
    
    //MARK: - Private properties
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    private let refreshControl = UIRefreshControl()
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var moneyBoxView: MoneySumView = {
        let moneyBoxView = MoneySumView.autoLayout()
        moneyBoxView.isHidden = true
        return moneyBoxView
    }()
    private let disposeBag = DisposeBag()

    //MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        guard viewModel.outputs.moneySumViewModel != nil, !isFiltering() else { return }
        showMoneyBox(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.inputs.ordersVCViewDidLoad()
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showMoneyBox(false)
    }
    
    //MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = Asset.Colors.background.color
        title = L10n.orderListTitle
        
        collectionView.backgroundColor = Asset.Colors.background.color
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerWithNib(cellType: OrderCollectionViewCell.self)
        collectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshOrderData), for: .valueChanged)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    private func setupNavBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.addSubview(moneyBoxView)
        
        NSLayoutConstraint.activate([
             moneyBoxView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20),
             moneyBoxView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -60)
        ])
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func showMoneyBox(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.moneyBoxView.alpha = show ? 1.0 : 0.0
        }
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    @objc private func refreshOrderData() {
        viewModel.inputs.didPullToRefresh {
            self.refreshControl.endRefreshing()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension OrdersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputs.didSelectItem(at: indexPath.row, isFiltered: isFiltering())
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

//MARK: - UICollectionViewDatasource
extension OrdersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering() ? viewModel.outputs.filteredItems.count : viewModel.outputs.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: OrderCollectionViewCell.self)
        cell.viewModel = isFiltering() ? viewModel.outputs.filteredItems[indexPath.row] : viewModel.outputs.items[indexPath.row]
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

//MARK: - UISearchResultsUpdating
extension OrdersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        showMoneyBox(!searchController.isActive)
        viewModel.inputs.filterContentForSearchText(searchBarText)
    }
}

//MARK: - Bind viewModel
extension OrdersViewController: BindableType {
    func bindViewModel() {
        viewModel.outputs.shouldReloadData.bind { [unowned self] _ in
            self.collectionView.reloadData()
        }.disposed(by: disposeBag)
        
        //using unowned self and weak viewModel to avoid retain cycle
        viewModel.outputs.shouldShowMoneyBox.bind { [unowned self, weak viewModel] isVisibleMoneyBox in
            guard let viewModel = viewModel else { return }
            self.moneyBoxView.viewModel = viewModel.outputs.moneySumViewModel
            self.moneyBoxView.isHidden = !isVisibleMoneyBox
            self.showMoneyBox(isVisibleMoneyBox)
        }.disposed(by: disposeBag)
    }
}
