//
//  MainListInteractor.swift
//  RedditApp
//
//  Created by Râmede on 15/08/21.
//

import Foundation

protocol MainListInteractable: AnyObject {
    func loadInitialInfo()
    func dissmissAll()
    func markAsRead()
    func getRedditPosts(after: String?)
}

final class MainListInteractor {
    private let presenter: MainListPresentable
    
    init (presenter: MainListPresentable) {
        self.presenter = presenter
    }
}

extension MainListInteractor: MainListInteractable {
    func loadInitialInfo() {
        getRedditPosts(after: nil)
    }
    
    func getRedditPosts(after: String?) {
        // Build URL
        let pageSize = 5
        let api = "https://www.reddit.com"
        let endpoint = "/top/.json?limit=\(String(pageSize))"
        
        var afterCondicional = ""
        if let after = after {
            afterCondicional = "&after=\(after)"
        }
        
        let url = URL(string: api + endpoint + afterCondicional)
        
        // Fetch
        NetworkDispatcher().execute(sessionURL: url!) { (result: Result<RedditPostsResponse, Error>) in
            switch result {
            case .success(let redditPostsResponse):
                self.handleRedditResponse(after: after, with: redditPostsResponse)
            case .failure(let error):
                print(error)
            }
        }
    }

    func dissmissAll() {
        
    }
    
    func markAsRead() {
        
    }
    
    private func handleRedditResponse(after: String?, with redditPostsResponse: RedditPostsResponse) {
        if let after = after {
            if after.isEmpty {
                presenter.presentPosts(posts: redditPostsResponse.data.children, after: redditPostsResponse.data.after)
                return
            }
            presenter.presentNextPostsPage(posts: redditPostsResponse.data.children, after: redditPostsResponse.data.after)
            return
        }
        presenter.presentPosts(posts: redditPostsResponse.data.children, after: redditPostsResponse.data.after)
    }
}
