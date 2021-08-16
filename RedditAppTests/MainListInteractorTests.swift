//
//  MainListInteractorTests.swift
//  RedditAppTests
//
//  Created by Râmede on 10/08/21.
//

import XCTest
@testable import RedditApp

private final class MainListPresenterSpy: MainListPresentable {
    private(set) var presentPostsCallsCount = 0
    private(set) var presentNextPostCallsCount = 0
    private(set) var dismissAllPostsCallsCount = 0
    private(set) var dimissPostCallsCount = 0
    private(set) var displayPostAsReadCallsCount = 0
    
    var viewController: MainListDisplayable?
    
    func presentPosts(posts: [RedditChildreen], after: String?) {
        presentPostsCallsCount += 1
    }
    
    func presentNextPostsPage(posts: [RedditChildreen], after: String?) {
        presentNextPostCallsCount += 1
    }
    
    func dismissAllPosts() {
        dismissAllPostsCallsCount += 1
    }
    
    func dimissPost(_ idx: IndexPath) {
        dimissPostCallsCount += 1
    }
    
    func displayPostAsRead(_ idx: Int) {
        displayPostAsReadCallsCount += 1
    }
}

final class MainListInteractorTests: XCTestCase {
    private var sut: MainListInteractor!
    private var presenterSpy: MainListPresenterSpy!

    override func setUpWithError() throws {
        presenterSpy = MainListPresenterSpy()
        sut = MainListInteractor(presenter: presenterSpy)
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterSpy = nil
    }
    
    func testDismissAllPosts_WhenDimissAllPostsInteractorIsCalled_ShouldCalledDimissAllPostInThePresenter() {
        sut.dismissAllPosts()
        
        XCTAssertEqual(presenterSpy.dismissAllPostsCallsCount, 1)
    }
    
    func testDimissAPost_WhenDimissAPostInteractorIsCalled_ShouldCalledDimissAllInThePresenter() {
        sut.dimissPost(IndexPath(item: 1, section: 1))
        
        XCTAssertEqual(presenterSpy.dimissPostCallsCount, 1)
    }

    func testDisplayPostAsRead_WhenDisplayPostAsReadInteractorIsCalled_ShouldCalledDisplayPostAsReadInThePresenter() {
        sut.displayPostAsRead(5)
        
        XCTAssertEqual(presenterSpy.displayPostAsReadCallsCount, 1)
    }

}

