//
//  TaipeiTravelAttractionService.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation

class TaipeiTravelAttractionService: AttractionService {
    static let shared = TaipeiTravelAttractionService()
    
    private init() {
    }
    
    func fetchAttractions(pageNumber: Int, completion: @escaping (Result<[Attraction], Error>) -> Void) {
        
    }
}
