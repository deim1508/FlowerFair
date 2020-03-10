//
//  UICollectionView+Nib.swift
//  FlowerFair
//
//  Created by babycougar on 2/18/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit.UICollectionView

/// Defines reusability behaviour
protocol ReusableView: class {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    
    /// Auto generated reuse identifier
    /// Same as the class name
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    /// Auto generated nib name
    /// Same as the class name
    static var nibName: String {
        return String(describing: self)
    }
}

// MARK: - UICollectionViewCell

extension UICollectionViewCell: ReusableView { }

extension UICollectionView {
    
    /// Register cell with the auto generated reuse identifier
    ///
    /// - Parameter cellType: cell class type
    final func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /// Register cell with the nib and the auto generated reuse identifier
    ///
    /// - Parameter cellType: cell class type
    final func registerWithNib<T: UICollectionViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Dequeue cell with type for a specific indexPath
    ///
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - cellType: cell class type
    /// - Returns: the reused cell
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
}
