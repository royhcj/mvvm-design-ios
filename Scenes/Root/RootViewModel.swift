//
//  RootViewModel.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/17.
//

import Foundation
import RxSwift
import RxCocoa

public class RootViewModel: RootViewModelProtocol {
    // MARK: - Observables
    public var onShowingAttractions = PublishSubject<Void>()
    
    // MARK: - Actions
    public func showAttractions() {
        onShowingAttractions.onNext(())
    }
    
    // MARK: - Setup
    public init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showAttractions()
        }
    }
    
}
