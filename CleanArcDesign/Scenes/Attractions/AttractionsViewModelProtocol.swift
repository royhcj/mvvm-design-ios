//
//  AttractionsViewModelProtocol.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import Combine

protocol AttractionsViewModelProtocol {
    
    // MARK: - Observables
    var attractions: Published<[Attraction]?>.Publisher { get }
    var busyFetching: Published<Bool>.Publisher { get }
    
    // MARK: - Actions
    func fetchMoreAttractions(startsOver: Bool)
    
    // MARK: - Dependencies
    var dependencies: AttractionsViewModelDependencies { get }
}

struct AttractionsViewModelDependencies {
    var attractionService: AttractionService
}



