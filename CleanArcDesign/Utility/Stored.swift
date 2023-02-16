//
//  Stored.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import Foundation
import RxCocoa

@propertyWrapper class Stored<T> {
    var behaviorRelay: BehaviorRelay<T>
    
    var projectedValue: BehaviorRelay<T> {
        return behaviorRelay
    }
    
    var wrappedValue: T {
        get {
            return behaviorRelay.value
        } set {
            behaviorRelay.accept(newValue)
        }
    }
    
    init(wrappedValue: T) {
        behaviorRelay = BehaviorRelay<T>(value: wrappedValue)
    }
}
