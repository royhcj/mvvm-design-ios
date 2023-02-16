//
//  TaipeiTravelAPI+Bridging.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation

extension ImageResource {
    init?(data: TaipeiTravelAPI.Models.Image) {
        guard let url = URL(string: data.src) else {
            return nil
        }
        self.init(url: url, subject: data.subject)
    }
}

extension Attraction {
    init(data: TaipeiTravelAPI.Models.Attraction) {
        self.init(
            id: data.id,
            name: data.name,
            introduction: data.introduction,
            openTimeText: data.openTime,
            address: data.address,
            coordinate: Coordinate(latitude: data.nlat,
                                   longitude: data.elon),
            images: data.images.map {
                        ImageResource(data: $0)
                    }.compactMap { $0 } )
    }
}
