//
//  AttractionsViewController.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import UIKit
import Utilities
import Domain
import SnapKit
import RxSwift
import RxCocoa
import RxOptional

public class AttractionsViewController: MvvmViewController<AttractionsViewModelProtocol> {
    let router: (RoutableViewController, Routes) -> Void
    
    private var bag = DisposeBag()
    
    internal var tableView: UITableView!
    
    
    // MARK: - Object/View lifecycle
    public init(viewModel: AttractionsViewModelProtocol,
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
        title = "Attractions"
        
        view.backgroundColor = .cyan
        
        tableView = UITableView()
        tableView.separatorStyle = .none
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
        
        rx.methodInvoked(#selector(viewWillAppear))
            .take(1)
            .subscribe(onNext: { [weak viewModel] _ in
                viewModel?.fetchMoreAttractions(startsOver: true)
            }).disposed(by: bag)
        
        tableView.rx.modelSelected(Attraction.self)
            .subscribe(onNext: { [weak self] attraction in
                guard let self = self else { return }
                self.router(self, .showAttraction(attraction))
            }).disposed(by: bag)
    }
}

