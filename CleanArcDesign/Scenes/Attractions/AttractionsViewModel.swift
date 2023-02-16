//
//  AttractionsViewModel.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import RxSwift
import RxCocoa

public class AttractionsViewModel: AttractionsViewModelProtocol {
    
    // MARK: - Observables
    var attractions: Observable<[Attraction]?> { $_attractions.asObservable() }
    var busyFetching: Observable<Bool> { $_busyFetching.asObservable() }
    
    
    // MARK: - Stores
    @Stored private var _attractions: [Attraction]?
    @Stored private var _busyFetching: Bool = false
    
    // MARK: - Actions
    public func fetchMoreAttractions(startsOver: Bool) {
        dependencies.attractionService.fetchAttractions(pageNumber: 1) { [weak self] result in
            switch result {
            case .success(let attractions):
                self?._attractions = attractions
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Setup
    init(dependencies: AttractionsViewModelDependencies) {
        self.dependencies = dependencies
        
        fetchMoreAttractions(startsOver: true)
    }
    
    // MARK: - Dependencies
    var dependencies: AttractionsViewModelDependencies
}

