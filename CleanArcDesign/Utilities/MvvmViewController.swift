//
//  MvvmViewController.swift
//  Utilities
//
//  Created by Roy on 2023/2/19.
//

import UIKit

public protocol ViewModelOwnable {
    associatedtype ViewModelType
    var viewModel: ViewModelType { get }
}

open class MvvmViewController<ViewModelType>: UIViewController,
                                              RoutableViewController,
                                              ViewModelOwnable {
    public var displayContext: UIDisplayContext?
    
    public var viewModel: ViewModelType
    
    public init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
