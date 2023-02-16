//
//  TaipeiTravelAPI.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import IORequestable


protocol TaipeiTravelRequestable: MoyaIORequestable {}
extension TaipeiTravelRequestable {
    var baseURL: URL {
        URL(string: "https://www.travel.taipei/open-api/en")!
    }
}

public class TaipeiTravelAPI {
    public typealias APIEncodable = TaipeiTravelAPIEncodable
    public typealias APIDecodable = TaipeiTravelAPIDecodable
}

public protocol TaipeiTravelAPIEncodable: Encodable & JsonEncodableKeyStrategyToSnakeCase {}

public protocol TaipeiTravelAPIDecodable: Decodable & JsonDecodableKeyStrategicFromSnakeCase {}
