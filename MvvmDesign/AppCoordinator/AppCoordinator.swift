//
//  AppCoordinator.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import UIKit
import Utilities
import Domain
import Services
import Scenes

class AppCoordinator {
    private let dependencies: Dependencies
    private let router: Router
    
    init() {
        dependencies = Dependencies(attractionService: TaipeiTravelAttractionService.shared)
        router = Router()
    }
    
    // MARK: - Routes
    func route(_ route: AppCoordinator.Routes, from source: RoutableViewController) {
        let behavior = routeBehavior(for: route, from: source)
        router.perform(behavior, from: source)
    }
    
    func routeBehavior(for route: AppCoordinator.Routes, from source: UIViewController) -> RouteBehavior {
        
        switch route {
        case .anyToRoot:
            let viewModel = RootViewModel()
            
            let viewController = RootViewController(
                viewModel: viewModel,
                router: { [weak self] source, route in
                    switch route {
                    case .showAttractions:
                        self?.route(.anyToAttractions, from: source)
                    }
                })
            
            let displayContext = UIDisplayContext(sourceViewController: source,
                                                  method: .embed(over: nil))
            
            return .show(target: viewController,
                         displayContext: displayContext)
            
        case .anyToAttractions:
            let dependencies = AttractionsViewModel.Dependencies(
                attractionService: dependencies.attractionService)
            
            let viewModel = AttractionsViewModel(dependencies: dependencies)
            
            let viewController = AttractionsViewController(
                viewModel: viewModel,
                router: { [weak self] source, route in
                    switch route {
                    case .showAttraction(let attraction):
                        self?.route(Routes.anyToAttraction(attraction: attraction), from: source)
                    }
                })
            
            let displayContext = UIDisplayContext(sourceViewController: source,
                                                  method: .present(animated: true))
            return .show(target: viewController,
                         displayContext: displayContext)
            
        case .anyToAttraction(let attraction):
            let dependencies = AttractionDetailViewModel.Dependencies(
                attractionService: dependencies.attractionService)
            
            let viewModel = AttractionDetailViewModel(dependencies: dependencies,
                                                      attraction: attraction)
            
            let viewController = AttractionDetailViewController(
                viewModel: viewModel) { source, route in
                    switch route {
                    case .back:
                        source.displayContext?.undisplay(source)
                    }
                }
            
            let displayContext = UIDisplayContext(sourceViewController: source,
                                                  method: .present(animated: true, presentationStyle: .formSheet))
            
            return .show(target: viewController,
                         displayContext: displayContext)
        }
    }
    
    // MARK: - Type Definitions
    struct Dependencies {
        var attractionService: AttractionService
    }
}

extension AppCoordinator {
    enum Routes {
        case anyToRoot
        case anyToAttractions
        case anyToAttraction(attraction: Attraction)
    }
}
