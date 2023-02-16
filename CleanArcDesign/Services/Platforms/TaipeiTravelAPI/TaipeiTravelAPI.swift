//
//  TaipeiTravelAPI.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import IORequestable
import Moya

protocol TaipeiTravelRequestable: MoyaIORequestable {}
extension TaipeiTravelRequestable {
    
    var baseURL: URL {
        URL(string: "https://www.travel.taipei/open-api/en")!
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    public static var provider: MoyaProvider<Self> {
        #if true // Switch to turn ON api logging
        let logger = BasicNetworkLoggerPlugin(verbose: true, cURL: true,
                                         requestDataFormatter: nil,
                                         responseDataFormatter:
        { data in
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
               let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                return jsonData
            } else {
                return data
            }
        })
        
        return MoyaProvider<Self>(plugins: [logger])
        #else
        return MoyaProvider<Self>()
        #endif
    }
}

public class TaipeiTravelAPI {
    public typealias APIEncodable = TaipeiTravelAPIEncodable
    public typealias APIDecodable = TaipeiTravelAPIDecodable
}

public protocol TaipeiTravelAPIEncodable: Encodable & JsonEncodableKeyStrategyToSnakeCase {}

public protocol TaipeiTravelAPIDecodable: Decodable & JsonDecodableKeyStrategicFromSnakeCase {}
