//
//  TaipeiTravelAPI+Models.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import IORequestable

extension TaipeiTravelAPI {
    class Models {
        
        struct Image: APIDecodable {
            var src: String
            var subject: String
            var ext: String
        }
        
        struct Attraction: APIDecodable {
            var id: Int
            var name: String
            var introduction: String
            var openTime: String
            var address: String
            var nlat: Double
            var elon: Double
            var images: [Image]
        }
    }
}
