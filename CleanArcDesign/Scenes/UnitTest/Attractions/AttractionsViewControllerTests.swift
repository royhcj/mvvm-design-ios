//
//  AttractionsViewControllerTests.swift
//  ScenesTests
//
//  Created by Roy on 2023/2/19.
//

import XCTest
import RxSwift
import Utilities
import Domain
@testable import Scenes

final class AttractionsViewControllerTests: XCTestCase {
    
    private var sut: AttractionsViewController!
    private var viewModel: AttractionsViewModelSpy!
    private var bag: DisposeBag!
    

    override func setUpWithError() throws {
        viewModel = AttractionsViewModelSpy()
        sut = AttractionsViewController(viewModel: viewModel,
                                        router: { source, route in
        })
        sut.view.frame = .init(x: 0, y: 0, width: 375, height: 675)
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        sut = nil
        viewModel = nil
        bag = nil
    }

    func test·AttractionsVC一when·initialized一should·have·title() throws {
        // Check
        XCTAssert(sut.title == "Attractions")
    }
    
    func test·AttractionsVC一when·observed·attractions一should·reload·table() throws {
        // Given
        let attractions = AttractionServiceMock.mockAttractions
        
        // Check
        let expectation = XCTestExpectation(description: "Should call reloadData")
        sut.tableView.rx.methodInvoked(#selector(UITableView.reloadData))
            .subscribe(onNext: { _ in
                expectation.fulfill()
            }).disposed(by: bag)
        
        // When
        viewModel.spyAttractions = attractions
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test·AttractionsVC一when·observed·attractions一should·have·good·cells() throws {
        // Given
        let attractions = AttractionServiceMock.mockAttractions
        
        // Check
        let expectation = XCTestExpectation(description: "Should have good cells")
        sut.tableView.rx.methodInvoked(#selector(UITableView.reloadData))
            .delay(.milliseconds(0), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { _ in
                for (index, attraction) in attractions.enumerated() {
                    let cell = self.sut.tableView.cellForRow(at: IndexPath(row: index, section: 0))
                    guard cell != nil else {
                        expectation.fulfill()
                        return
                    }
                    guard let cell = cell as? AttractionCell else {
                        XCTFail("Unexpected table cell type")
                        return
                    }
                    XCTAssert((cell.value(forKeyPath: "titleLabel") as! UILabel).text == attraction.name)
                    XCTAssert((cell.value(forKeyPath: "introductionLabel") as! UILabel).text ?? "" == attraction.introduction)
                }
                expectation.fulfill()
            }).disposed(by: bag)
        
        // When
        viewModel.spyAttractions = attractions
        
        wait(for: [expectation], timeout: 1)
    }
}

private class AttractionsViewModelSpy: AttractionsViewModelProtocol {
    var attractions: Observable<[Attraction]?> { $spyAttractions.asObservable() }
    var busyFetching: Observable<Bool> { $spyBusy.asObservable() }
    
    @Stored public var spyBusy: Bool = false
    @Stored public var spyAttractions: [Attraction]?
    
    func fetchMoreAttractions(startsOver: Bool) {}
}

private class AttractionServiceMock: AttractionService {
    func fetchAttractions(pageNumber: Int,
                          completion: @escaping (Result<[Domain.Attraction], Error>) -> Void) {
        
    }
    
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
