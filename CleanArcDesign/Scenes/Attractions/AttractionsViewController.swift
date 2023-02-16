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
        tableView.register(AttractionCell.self, forCellReuseIdentifier: AttractionCell.cellIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        viewModel.attractions
            .filterNil()
            .bind(to: tableView.rx.items(cellIdentifier: AttractionCell.cellIdentifier,
                                         cellType: AttractionCell.self)) {
                (index, attraction, cell) in
                cell.configure(with: attraction)
            }.disposed(by: bag)
        
        
        tableView.rx.modelSelected(Attraction.self)
            .subscribe(onNext: { [weak self] attraction in
                guard let self = self else { return }
                self.router(self, .showAttraction(id: attraction.id))
            }).disposed(by: bag)
    }
}

