//
//  MainViewController.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/17.
//

import UIKit
import Utilities

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
        
        coordinator.route(.anyToRoot, from: self)
    }
    
    private func setupView() {
        view.backgroundColor = .gray
        
    }
    
    
}
