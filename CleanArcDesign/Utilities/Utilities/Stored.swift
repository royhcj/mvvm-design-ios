//
//  Stored.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import RxCocoa

@propertyWrapper public class Stored<T> {
    var behaviorRelay: BehaviorRelay<T>
    
    public var projectedValue: BehaviorRelay<T> {
        return behaviorRelay
    }
    
    public var wrappedValue: T {
        get {
            return behaviorRelay.value
        } set {
            behaviorRelay.accept(newValue)
        }
    }
    
    public init(wrappedValue: T) {
        behaviorRelay = BehaviorRelay<T>(value: wrappedValue)
    }
}
