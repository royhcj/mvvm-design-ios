//
//  AppRouter.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import UIKit

class AppRouter: Router {
    let dependencies: Dependencies
    
    override init() {
        dependencies = Dependencies(attractionService: TaipeiTravelAttractionService.shared)
        super.init()
    }
    
    // MARK: - Type Definitions
    struct Dependencies {
        var attractionService: AttractionService
    }
}
