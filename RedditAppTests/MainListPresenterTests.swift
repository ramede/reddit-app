//
//  MainListPresenterTests.swift
//  RedditAppTests
//
//  Created by Râmede on 15/08/21.
//

import XCTest
@testable import RedditApp

private final class MainListViewControllerSpy: MainListDisplayable {
    private(set) var dimissAllPostsCallsCount = 0
    private(set) var dismissPostCallsCount = 0
    private(set) var displayPostsCallsCount = 0
    private(set) var displayNextPostsPageCallsCount = 0
    private(set) var displayPostsAsReadCallsCount = 0
    private(set) var displayLoadingCallsCount = 0
    
    private(set) var postsReceived: [RedditChildreen] = []
    
    func dismissAllPosts() {
        dimissAllPostsCallsCount += 1
        postsReceived = []
    }
    
    func dismissPost(_ idx: IndexPath) {
        dismissPostCallsCount += 1
        postsReceived.remove(at: idx.row)
    }
    
    func displayPosts(with posts: [RedditChildreen], after: String?) {
        displayPostsCallsCount += 1
        postsReceived = posts
    }
    
    func displayNextPostsPage(with posts: [RedditChildreen], after: String?) {
        displayNextPostsPageCallsCount += 1
        postsReceived.append(contentsOf: posts)
    }
    
    func displayPostAsRead(_ idx: Int) {
        displayPostsAsReadCallsCount += 1
        postsReceived[idx].didRead = true
    }
    
    func displayLoading(_ isLoading: Bool) {
        displayLoadingCallsCount += 1
    }

}

final class MainListPresenterTests: XCTestCase {
    private var sut: MainListPresenter!
    private var viewSpy: MainListViewControllerSpy!
    private var redditChildreenListMock: [RedditChildreen] = []


    override func setUpWithError() throws {
        viewSpy = MainListViewControllerSpy()
        sut = MainListPresenter()
        sut.viewController = viewSpy
        
        let postMockOne = RedditChildreen.mock()
        
        let postMockTwo = RedditChildreen.mock(
            didRead: false,
            kind: "Listing",
            data: RedditPost.mock(
                subreddit: "facepalm",
                title: "Does it get more childish?",
                author: "azgrunt",
                created: 1629004473,
                imageUrl: "https://i.redd.it/mlubakm4hgh71.jpg",
                comments: 350
            )
        )
        
        let postMockThree = RedditChildreen.mock(
            didRead: false,
            kind: "Listing",
            data: RedditPost.mock(
                subreddit: "memes",
                title: "Butter in a frying pan",
                author: "opum123",
                created: 1629022805,
                imageUrl: "https://i.redd.it/mwy36x1fzhh71.gif",
                comments: 350
            )
        )
        
        let postMockFour = RedditChildreen.mock(
            didRead: false,
            kind: "Listing",
            data: RedditPost.mock(
                subreddit: "aww",
                title: "Guina Pig Traffic",
                author: "Crafty526",
                created: 1629022805,
                imageUrl: "https://v.redd.it/yps19epcihh71",
                comments: 896
            )
        )
        
        redditChildreenListMock.append(postMockOne)
        redditChildreenListMock.append(postMockTwo)
        redditChildreenListMock.append(postMockThree)
        redditChildreenListMock.append(postMockFour)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewSpy = nil
    }

    func testPresentPosts_WhenPresentPosts_ShoulCallDisplayPosts() {
        sut.presentPosts(posts: redditChildreenListMock, after: nil)
        
        XCTAssertEqual(viewSpy.displayPostsCallsCount, 1)
    }

    func testPresentPosts_WhenPresentPosts_ShouldReceiveAllPostsInView() {
        sut.presentPosts(posts: redditChildreenListMock, after: nil)
        
        XCTAssertEqual(viewSpy.postsReceived.count, redditChildreenListMock.count)
    }

    func testPresentNextPostsPage_WhenPresentNextPostsPage_ShoulCallDisplayNextPostsPageCallsCount() {
        sut.presentNextPostsPage(posts: redditChildreenListMock, after: "t3_p4q7q3")
        
        XCTAssertEqual(viewSpy.displayNextPostsPageCallsCount, 1)
    }

    func testPresentNextPostsPage_WhenPresentNextPostsPage_ShouldReceiveAllPostsInView() {
        sut.presentPosts(posts: redditChildreenListMock, after: nil)
        sut.presentNextPostsPage(posts: redditChildreenListMock, after: "t3_p4q7q3")
        
        XCTAssertEqual(viewSpy.postsReceived.count, redditChildreenListMock.count * 2)
    }
    
    func testDismissAllPosts_WhenDismissAllPostsIsCalled_ShouldDismissAllPosts() {
        sut.dismissAllPosts()
        
        XCTAssertEqual(viewSpy.dimissAllPostsCallsCount, 1)
        XCTAssertEqual(viewSpy.postsReceived.count, 0)
    }
    
    func testDismissThePost_WhenDismissThePostIsCalled_ShouldDimissThePost() {
        sut.presentPosts(posts: redditChildreenListMock, after: nil)
        sut.dimissPost(IndexPath(row: 2, section: 1))
        
        let dimissedPost = viewSpy.postsReceived.filter {
            $0.data.author == "opum123"
        }.first
        
        XCTAssertEqual(viewSpy.dismissPostCallsCount, 1)
        XCTAssertNil(dimissedPost)
    }
    
    func testDisplayPostAsRead_WhenDisplayPostAsReadIsCalled_ShouldDisplayPostAsRead() {
        sut.presentPosts(posts: redditChildreenListMock, after: nil)
        sut.displayPostAsRead(2)
        
        XCTAssertEqual(viewSpy.postsReceived[2].didRead, true)
        XCTAssertEqual(viewSpy.displayPostsAsReadCallsCount, 1)
    }
    
    func testPresentLoading_WhenPresentLoadingIsCalled_ShouldDisplayLoading() {
        sut.presentLoading(true)
        
        XCTAssertEqual(viewSpy.displayLoadingCallsCount, 1)
    }

}

extension RedditPost {
    static func mock(
        subreddit: String = "wholesomememes",
        title: String = "I'll be brave for you",
        author: String = "Macroc0sM",
        created: Int = 1628993186,
        imageUrl: String? = "https://i.redd.it/of734rlkjfh71.jpg",
        comments: Int = 257
    ) -> RedditPost {
        .init(
            subreddit: subreddit,
            title: title,
            author: author,
            created: created,
            imageUrl: imageUrl,
            comments: comments
        )
    }
}

extension RedditChildreen {
    static func mock(
        didRead: Bool = false,
        kind: String = "Listing",
        data: RedditPost = RedditPost.mock()
    ) -> RedditChildreen {
        .init(
            didRead: didRead,
            kind: kind,
            data: data
        )
    }
}
