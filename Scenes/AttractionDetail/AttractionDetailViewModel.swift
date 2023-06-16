//
//  AttractionDetailViewModel.swift
//  Scenes
//
//  Created by Roy on 2023/6/16.
//

import Foundation
import Utilities
import Domain
import RxSwift
import RxCocoa

public class AttractionDetailViewModel: AttractionDetailViewModelProtocol {
    
    // MARK: - Observables
    public var attraction: Observable<Attraction> { $_attraction.asObservable() }
    public var busyFetching: Observable<Bool> { $_busyFetching.asObservable() }
    
    // MARK: - Stores
    @Stored private var _attraction: Attraction
    @Stored private var _busyFetching: Bool = false
    
    // MARK: - Actions
    
    // MARK: - Setup
    public init(dependencies: Dependencies,
                attraction: Attraction) {
        self.dependencies = dependencies
        self._attraction = attraction
    }
    
    // MARK: - Dependencies
    private var dependencies: Dependencies
    
    public struct Dependencies {
        var attractionService: AttractionService
        
        public init(attractionService: AttractionService) {
            self.attractionService = attractionService
        }
    }
}
