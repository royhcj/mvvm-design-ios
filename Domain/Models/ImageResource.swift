//
//  ImageResource.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation

public struct ImageResource: Equatable {
    public let url: URL
    public let subject: String
    
    public init(url: URL, subject: String) {
        self.url = url
        self.subject = subject
    }
}
