//
//  AttractionDetailViewController.swift
//  Scenes
//
//  Created by Roy on 2023/6/16.
//

import UIKit
import Utilities
import Domain
import SnapKit
import RxSwift
import RxCocoa
import RxOptional

public class AttractionDetailViewController: MvvmViewController<AttractionDetailViewModelProtocol> {
    let router: (RoutableViewController, Routes) -> Void
    
    private var bag = DisposeBag()
    
    internal var imageView: UIImageView!
    internal var titleLabel: UILabel!
    
    // MARK: - Object/View lifecycle
    public init(viewModel: AttractionDetailViewModelProtocol,
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
        title = "Attraction Detail"
        
        view.backgroundColor = .systemYellow
        
        let vstack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .fill
            view.addSubview(stack)
            stack.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            return stack
        }()
        
        imageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.snp.makeConstraints {
                $0.height.equalTo(300)
            }
            vstack.addArrangedSubview(imageView)
            return imageView
        }()
        
        titleLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = .darkGray
            vstack.addArrangedSubview(label)
            return label
        }()
        
        vstack.addArrangedSubview(UIView())
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        viewModel.attraction
            .subscribe(onNext: { [weak self] attraction in
                self?.imageView.kf.setImage(with: attraction.images.first?.url)
                self?.titleLabel.text = attraction.name
            }).disposed(by: bag)
    }
    
}
