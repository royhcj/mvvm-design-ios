//
//  Attraction.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation

public struct Attraction {
    var id: Int
    var name: String
    var introduction: String
    var openTimeText: String
    var address: String
    var coordinate: Coordinate
    var images: [ImageResource]
}
