//
//  Attraction.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation

public struct Attraction: Equatable {
    public var id: Int
    public var name: String
    public var introduction: String
    public var openTimeText: String
    public var address: String
    public var coordinate: Coordinate
    public var images: [ImageResource]

    public init(id: Int, name: String, introduction: String, openTimeText: String, address: String, coordinate: Coordinate, images: [ImageResource]) {
        self.id = id
        self.name = name
        self.introduction = introduction
        self.openTimeText = openTimeText
        self.address = address
        self.coordinate = coordinate
        self.images = images
    }
}
