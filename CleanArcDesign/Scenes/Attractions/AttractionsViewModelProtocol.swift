//
//  AttractionsViewModelProtocol.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import Utilities
import Domain
import RxSwift
import RxCocoa

public protocol AttractionsViewModelProtocol: AnyObject {
    
    // MARK: - Observables
    var attractions: Observable<[Attraction]?> { get }
    var busyFetching: Observable<Bool> { get }
    
    // MARK: - Actions
    func fetchMoreAttractions(startsOver: Bool)
    
    // MARK: - Dependencies
    var dependencies: AttractionsViewModelDependencies { get }
}

public struct AttractionsViewModelDependencies {
    var attractionService: AttractionService
    
    public init(attractionService: AttractionService) {
        self.attractionService = attractionService
    }
}



