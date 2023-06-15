//
//  AttractionsViewModel.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import Utilities
import Domain
import RxSwift
import RxCocoa


public class AttractionsViewModel: AttractionsViewModelProtocol {
    
    // MARK: - Observables
    public var attractions: Observable<[Attraction]?> { $_attractions.asObservable() }
    public var busyFetching: Observable<Bool> { $_busyFetching.asObservable() }
    
    
    // MARK: - Stores
    @Stored private var _attractions: [Attraction]?
    @Stored private var _busyFetching: Bool = false
    
    // MARK: - Actions
    public func fetchMoreAttractions(startsOver: Bool) {
        guard !_busyFetching else { return }
        
        _busyFetching = true
        
        dependencies.attractionService.fetchAttractions(pageNumber: 1) { [weak self] result in
            self?._busyFetching = false
            
            switch result {
            case .success(let attractions):
                self?._attractions = attractions
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Setup
    public init(dependencies: AttractionsViewModelDependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Dependencies
    public var dependencies: AttractionsViewModelDependencies
    
    public struct AttractionsViewModelDependencies {
        var attractionService: AttractionService
        
        public init(attractionService: AttractionService) {
            self.attractionService = attractionService
        }
    }
}

