//
//  AttractionsViewController.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxOptional

class AttractionsViewController: UIViewController,
                                 RoutableViewController {
    var displayContext: UIDisplayContext?
    
    let viewModel: AttractionsViewModelProtocol
    let router: (RoutableViewController, Routes) -> Void
    
    private var bag = DisposeBag()
    
    private var tableView: UITableView!
    
    
    // MARK: - Object/View lifecycle
    init(viewModel: AttractionsViewModelProtocol,
         router: @escaping (RoutableViewController, Routes) -> Void) {
        self.viewModel = viewModel
        self.router = router
        super.init()
    
        createLayout()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func createLayout() {
        title = "Attractions"
        
        view.backgroundColor = .systemCyan
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        viewModel.attractions
            .filterNil()
            .bind(to: tableView.rx.items(cellIdentifier: "AttractionCell", cellType: UITableViewCell.self)) { (index, model, cell) in
                
            }.disposed(by: bag)
    }
}

