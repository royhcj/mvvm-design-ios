//
//  Coordinate.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation

public struct Coordinate: Equatable {
    public var latitude: Double
    public var longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
