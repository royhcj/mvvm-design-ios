//
//  AttractionService.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation

public protocol AttractionService {
    func fetchAttractions(pageNumber: Int, completion: @escaping (Result<[Attraction], Error>) -> Void)
}
