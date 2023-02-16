//
//  AppRouter.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import UIKit

class AppCoordinator {
    let dependencies: Dependencies
    let router: Router
    
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
        case .anyToAttractions:
            let dependencies = AttractionsViewModelDependencies(
                attractionService: dependencies.attractionService)
            let viewModel = AttractionsViewModel(dependencies: dependencies)
            let viewController = AttractionsViewController(viewModel: viewModel)
            let displayContext = UIDisplayContext(sourceViewController: source,
                                                  method: .present(animated: true))
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
    case anyToAttractions
    }
}
