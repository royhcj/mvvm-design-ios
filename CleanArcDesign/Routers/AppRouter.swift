//
//  AppRouter.swift
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
            let dependencies = AttractionsViewModelDependencies(
                attractionService: dependencies.attractionService)
            
            let viewModel = AttractionsViewModel(dependencies: dependencies)
            
            let viewController = AttractionsViewController(
                viewModel: viewModel,
                router: { [weak self] source, route in
                    switch route {
                    case .showAttraction(let id):
                        self?.route(Routes.anyToAttraction(id: id), from: source)
                    }
                })
            
            let displayContext = UIDisplayContext(sourceViewController: source,
                                                  method: .present(animated: true))
            return .show(target: viewController,
                         displayContext: displayContext)
            
        case .anyToAttraction(let id):
            print(id)
            return .custom
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
        case anyToAttraction(id: Int)
    }
}
