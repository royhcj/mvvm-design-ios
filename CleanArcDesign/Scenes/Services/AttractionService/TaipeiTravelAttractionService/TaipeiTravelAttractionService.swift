//
//  TaipeiTravelAttractionService.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import Domain

public class TaipeiTravelAttractionService: AttractionService {
    public static let shared = TaipeiTravelAttractionService()
    
    private init() {
    }
    
    public func fetchAttractions(pageNumber: Int, completion: @escaping (Result<[Attraction], Error>) -> Void) {
        
        TaipeiTravelAPI.FetchAttractions(.init(page: pageNumber))
            .execute { result in
                switch result {
                case .success(let responseBody):
                    let attractions = responseBody.data.map {
                        Attraction(data: $0)
                    }
                    completion(.success(attractions))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
}
