//
//  MainViewController.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/17.
//

import UIKit


class MainViewController: UIViewController, RoutableViewController {
    var displayContext: UIDisplayContext?
    
    var coordinator: AppCoordinator
    
    // MARK: - Object lifecycle
    required init?(coder: NSCoder) {
        fatalError("Unexpected initializer")
    }
    
    override init(nibName: String?, bundle: Bundle?) {
        coordinator = AppCoordinator()
        
        super.init(nibName: nibName, bundle: bundle)
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .gray
        
        coordinator.route(.anyToRoot, from: self)
    }
    
    
}
