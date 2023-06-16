//
//  AttractionsViewModelTests.swift
//  CleanArcDesignTests
//
//  Created by Roy on 2023/2/17.
//

//@testable import MvvmDesign
import XCTest
import RxSwift
import RxCocoa
import Domain
import Scenes


final class AttractionsViewModelTests: XCTestCase {
    
    private var sut: AttractionsViewModel!
    private var bag: DisposeBag!
    
    private var attractionService: AttractionServiceMock!
    
    override func setUpWithError() throws {
        attractionService = AttractionServiceMock()
        
        sut = AttractionsViewModel(dependencies: .init(
                attractionService: attractionService))
        bag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        bag = nil
    }
    
    func test·AttractionsViewModel·given·valid·remoteAttractions一when·fetch·attractions一should·output·attractions() {
        // Given
        attractionService.fetchAttractionsResponse = .success(AttractionServiceMock.mockAttractions)
        
        // When
        let expectation = XCTestExpectation(description: "Expected Attractions")
        var expectedSequence: [[Attraction]?] = [nil, AttractionServiceMock.mockAttractions]
        
        sut.attractions
            .subscribe(onNext: { attractions in
                guard attractions == expectedSequence[0] else {
                    XCTFail("Unexpected attractions")
                    return
                }
                if expectedSequence.count == 1 {
                    expectation.fulfill()
                }
                expectedSequence.removeFirst()
            }).disposed(by: bag)
        
        sut.fetchMoreAttractions(startsOver: true)
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func test·AttractionsViewModel·given·valid·remote·attractions一when·fetch·attractions一should·output·busy·and·not·busy() {
        // Given
        attractionService.fetchAttractionsResponse = .success(AttractionServiceMock.mockAttractions)
        
        // When
        let expectationBusy = XCTestExpectation(description: "Expected Busy")
        let expectationNotBusy = XCTestExpectation(description: "Expected Not Busy")
        let expectedValues = [false, true, false]
        var nextIndex = 0
        
        sut.busyFetching
            .subscribe(onNext: { busy in
                guard busy == expectedValues[nextIndex] else {
                    XCTFail("Unexpected busy state")
                    return
                }
                
                if nextIndex == 1 {
                    expectationBusy.fulfill()
                } else if nextIndex == 2 {
                    expectationNotBusy.fulfill()
                }
                nextIndex += 1
            }).disposed(by: bag)
        
        sut.fetchMoreAttractions(startsOver: true)
        
        // Then
        wait(for: [expectationBusy, expectationNotBusy], timeout: 10)
    }
    
    func testAttractionsViewModel·given·invalid·remote·attractions一when·fetch·attractions一should·output·busy·and·not·busy() {
        // Given
        attractionService.fetchAttractionsResponse = .failure(AttractionServiceError.underlyingError)
        
        // When
        let expectationBusy = XCTestExpectation(description: "Expected Busy")
        let expectationNotBusy = XCTestExpectation(description: "Expected Not Busy")
        var expectedValues = [false, true, false]
        
        sut.busyFetching
            .subscribe(onNext: { busy in
                guard busy == expectedValues[0] else {
                    XCTFail("Unexpected busy state")
                    return
                }
                
                if expectedValues.count == 2 {
                    expectationBusy.fulfill()
                } else if expectedValues.count == 1 {
                    expectationNotBusy.fulfill()
                }
                
                expectedValues.removeFirst()
            }).disposed(by: bag)
        
        sut.fetchMoreAttractions(startsOver: true)
        
        // Then
        wait(for: [expectationBusy, expectationNotBusy], timeout: 10)
    }
}

private class AttractionServiceMock: AttractionService {
    func fetchAttractions(pageNumber: Int, completion: @escaping (Result<[Attraction], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let response = self.fetchAttractionsResponse {
                completion(response)
            } else {
                completion(.failure(AttractionServiceError.underlyingError))
            }
        }
    }
    
    var fetchAttractionsResponse: Result<[Attraction], Error>?

    // MARK: - Mock Data
    static let mockAttractions: [Attraction] = [
        .init(id: 1,
              name: "Name 1",
              introduction: "Intro 1",
              openTimeText: "",
              address: "Address 1",
              coordinate: Coordinate(latitude: 0, longitude: 0),
              images: []),
        .init(id: 2,
              name: "Name 2",
              introduction: "Intro 2",
              openTimeText: "",
              address: "Address 2",
              coordinate: Coordinate(latitude: 0, longitude: 0),
              images: []),
        .init(id: 3,
              name: "Name 3",
              introduction: "Intro 3",
              openTimeText: "",
              address: "Address 3",
              coordinate: Coordinate(latitude: 0, longitude: 0),
              images: [])
    ]
    
}
