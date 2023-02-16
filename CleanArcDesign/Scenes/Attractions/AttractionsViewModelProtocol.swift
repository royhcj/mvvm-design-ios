//
//  AttractionsViewModelProtocol.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import RxSwift
import RxCocoa

protocol AttractionsViewModelProtocol {
    
    // MARK: - Observables
    var attractions: Observable<[Attraction]?> { get }
    var busyFetching: Observable<Bool> { get }
    
    // MARK: - Actions
    func fetchMoreAttractions(startsOver: Bool)
    
    // MARK: - Dependencies
    var dependencies: AttractionsViewModelDependencies { get }
}

struct AttractionsViewModelDependencies {
    var attractionService: AttractionService
}



