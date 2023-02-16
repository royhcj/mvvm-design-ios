//
//  RootViewModelProtocol.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/17.
//

import Foundation
import RxSwift
import RxCocoa

protocol RootViewModelProtocol: AnyObject {
    // MARK: - Observables
    var onShowingAttractions: PublishSubject<Void> { get }
    
    // MARK: - Actions
    func showAttractions()
}
