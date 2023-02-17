//
//  Stored+Tests.swift
//  UtilitiesTests
//
//  Created by Roy on 2023/2/17.
//

import XCTest
import RxSwift
@testable import Utilities

final class Stored·Tests: XCTestCase {
    @Stored private var sutInt: Int = 0
    private var bag: DisposeBag!
    
    override func setUpWithError() throws {
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        bag = nil
    }
    
    func test·stored一when·assigning·some·value一should·be·that·value() throws {
        // Given
        let values: [Int] = [0, 1, 3, 500]
        
        for value in values {
            // When
            sutInt = value
            
            // Check
            XCTAssert(sutInt == value, "Should have same value as the one assigned")
        }
    }
    
    func test·stored一when·assigning·some·value一should·observe·that·value() throws {
        // Given
        var values: [Int] = [0, 1, 3, 500]
        
        // Check
        $sutInt.skip(1)
            .subscribe(onNext: { value in
                XCTAssert(value == values[0], "Should observe the same value as assigned")
                values.removeFirst()
            }).disposed(by: bag)
        
        for value in values {
            // When
            sutInt = value
        }
    }
}
