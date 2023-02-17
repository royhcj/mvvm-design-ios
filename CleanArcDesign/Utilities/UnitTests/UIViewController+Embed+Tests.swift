//
//  UtilitiesTests.swift
//  UtilitiesTests
//
//  Created by Roy on 2023/2/17.
//

import XCTest
@testable import Utilities

final class UIViewController·Embed·Tests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testViewController_whenEmbeddingChildWithoutSpecifyingView_shouldEmbedChild() throws {
        // Given
        let parent = UIViewController()
        let child = ViewControllerSpy()
        
        // When
        parent.embed(child)
        
        // Check
        XCTAssert(child.view.superview == parent.view, "Child's superview should be parent's view.")
        XCTAssert(child.parent == parent, "Child should have parent.")
        XCTAssert(child.hasCalledDidMoveToParent, "Child should move to parent.")
    }
    
    func testViewController_whenEmbeddingChildOverSpecifiedView_shouldEmbedChild() throws {
        // Given
        let parent = UIViewController()
        let child = ViewControllerSpy()
        
        let parentSubview = UIView()
        parentSubview.frame = parent.view.bounds
        parent.view.addSubview(parentSubview)
        
        // When
        parent.embed(child, over: parentSubview)
        
        // Check
        XCTAssert(child.view.superview == parentSubview, "Child's superview should be specified view.")
        XCTAssert(child.parent == parent, "Child should have parent.")
        XCTAssert(child.hasCalledDidMoveToParent, "Child should move to parent.")
    }
    
    func testViewController_whenUnembedFromParent_shouldUnembed() throws {
        // Given
        let parent = UIViewController()
        let child = ViewControllerSpy()
        parent.embed(child)
        child.hasCalledDidMoveToParent = false // reset so we can check later
        
        // When
        child.unembedFromParent()
        
        // Check
        XCTAssert(child.view.superview == nil, "Child's view should not have superview.")
        XCTAssert(child.parent == nil, "Child should not have parent.")
        XCTAssert(child.hasCalledDidMoveToParent, "didMoveToParent should be called.")
    }
    
    // MARK: - Type Definitions
    private class ViewControllerSpy: UIViewController {
        public var hasCalledDidMoveToParent = false
        
        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            
            hasCalledDidMoveToParent = true
        }
    }

}
