//
//  MainListViewControllerTests.swift
//  RedditAppTests
//
//  Created by Râmede on 15/08/21.
//

import XCTest
@testable import RedditApp

private final class MainListInteractorSpy: MainListInteractable {
    private(set) var loadInitialInfoCallsCount = 0
    private(set) var getRedditPostsCallsCount = 0
    private(set) var dismissAllPostsCallsCount = 0
    private(set) var dismissPostCallsCount = 0
    private(set) var displayPostAsReadCallsCount = 0
    
    func loadInitialInfo() {
        loadInitialInfoCallsCount += 1
    }
    
    func getRedditPosts(after: String?) {
        getRedditPostsCallsCount += 1
    }
    
    func dismissAllPosts() {
        dismissAllPostsCallsCount += 1
    }
    
    func dimissPost(_ idx: IndexPath) {
        dismissPostCallsCount += 1
    }
    
    func displayPostAsRead(_ idx: Int) {
        displayPostAsReadCallsCount += 1
    }
}

final class MainLisViewControllerTests: XCTestCase {
    private var sut: MainListViewController!
    private var interactorSpy: MainListInteractorSpy!

    override func setUpWithError() throws {
        interactorSpy = MainListInteractorSpy()
        sut = MainListViewController(interactor: interactorSpy)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSceneStarted_WhenViewAppears_ShouldLoadInitialState() {
        sut.loadView()
        sut.viewDidLoad()

        XCTAssertEqual(interactorSpy.loadInitialInfoCallsCount, 1)
    }
    
    func testDismissAllPosts_WhenDismissAllPostsIsTapped_ShouldCalledDismissAllPostsInteractor() {
        sut.didTapOnDimissAll()
        
        XCTAssertEqual(interactorSpy.dismissAllPostsCallsCount, 1)
    }
    
    func testDismissPost_WhenDismissAPostIsTapped_ShouldCalledDismissAPostInteractor() {
        sut.didTapOnDimissPost(idx: IndexPath(item: 1, section: 1))
        
        XCTAssertEqual(interactorSpy.dismissPostCallsCount, 1)
    }
    
    func testDisplayPostAsRead_WhenDisplayPostAsReadIsTapped_ShouldCalledDisplayPostAsReadInteractor() {
        sut.didSelectPost(item: RedditChildreen.mock(), idx: 3)
        
        XCTAssertEqual(interactorSpy.displayPostAsReadCallsCount, 1)
    }
}
