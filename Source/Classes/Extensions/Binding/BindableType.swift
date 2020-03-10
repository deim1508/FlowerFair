//
//  BindableType.swift
//  FlowerFair
//
//  Created by babycougar on 2/17/20.
//  Copyright © 2020 babycougar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol BindableType: class {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        
        var disposeBag: DisposeBag! = DisposeBag()
        self.rx.sentMessage(#selector(UIViewController.viewDidLoad)).subscribe { [weak self] _ in
            self?.bindViewModel()
            disposeBag = nil
        }.disposed(by: disposeBag)
    }
}
