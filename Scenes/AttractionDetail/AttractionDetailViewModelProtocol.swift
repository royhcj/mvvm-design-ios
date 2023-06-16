//
//  AttractionDetailViewModelProtocol.swift
//  Scenes
//
//  Created by Roy on 2023/6/16.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

public protocol AttractionDetailViewModelProtocol: AnyObject {
    
    // MARK: - Observables
    var attraction: Observable<Attraction> { get }
    var busyFetching: Observable<Bool> {get }
    
    // MARK: - Actions
    
}
