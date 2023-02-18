//
//  TaipeiTravelAPI+Attraction.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import IORequestable

extension TaipeiTravelAPI {
    
    struct FetchAttractions: TaipeiTravelRequestable {
        var spec = Spec(.get, "Attractions/All")
        
        struct Input: APIEncodable {
            var page: Int
        }
        
        struct Output: APIDecodable {
            var total: Int
            var data: [Models.Attraction]
        }
    }
    
}
