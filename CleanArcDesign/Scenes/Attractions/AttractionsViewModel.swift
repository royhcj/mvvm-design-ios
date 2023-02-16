//
//  AttractionsViewModel.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import Combine

public class AttractionsViewModel: AttractionsViewModelProtocol {
    
    // MARK: - Observables
    var attractions: Published<[Attraction]?>.Publisher { $_attractions }
    var busyFetching: Published<Bool>.Publisher { $_busyFetching }
    
    
    // MARK: - Stores
    @Published private var _attractions: [Attraction]?
    @Published private var _busyFetching: Bool = false
    
    // MARK: - Actions
    public func fetchMoreAttractions(startsOver: Bool) {
        dependencies.fetchAttraction.fetchAttractions(pageNumber: 1) { [weak self] result in
            switch result {
            case .success(let attractions):
                self?.attractions = attractions
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Setup
    init(dependencies: AttractionsViewModelDependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Dependencies
    var dependencies: AttractionsViewModelDependencies
}

