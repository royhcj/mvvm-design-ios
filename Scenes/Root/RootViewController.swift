//
//  RootViewController.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/17.
//

import UIKit
import Utilities
import SnapKit
import RxSwift
import RxCocoa
import RxOptional

public class RootViewController: MvvmViewController<RootViewModelProtocol> {
    var router: (RoutableViewController, Routes) -> Void
    
    private var bag = DisposeBag()
    
    // MARK: - Object/View lifecycle
    public init(viewModel: RootViewModelProtocol,
                router: @escaping (RoutableViewController, Routes) -> Void) {
        self.router = router
        super.init(viewModel: viewModel)
    
        createLayout()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Layout
    private func createLayout() {
        view.backgroundColor = .systemPurple
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        viewModel.onShowingAttractions
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.router(self, .showAttractions)
            }).disposed(by: bag)
    }
}
