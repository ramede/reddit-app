//
//  MainListPresenter.swift
//  RedditApp
//
//  Created by Râmede on 15/08/21.
//

import UIKit

protocol MainListPresentable: AnyObject {
    var viewController: MainListDisplayable? { get set }
    func presentPosts(posts: [RedditChildreen], after: String?)
    func presentNextPostsPage(posts: [RedditChildreen], after: String?)
    func dismissAllPosts()
    func dimissPost(_ idx: IndexPath)
    func displayPostAsRead(_ idx: Int)
    func presentLoading(_ isLoading: Bool)
}

final class MainListPresenter {
    weak var viewController: MainListDisplayable?
}

extension MainListPresenter: MainListPresentable {
    func presentPosts(posts: [RedditChildreen], after: String?) {
        viewController?.displayPosts(with: posts, after: after)
    }

    func presentNextPostsPage(posts: [RedditChildreen], after: String?) {
        viewController?.displayNextPostsPage(with: posts, after: after)
    }
    
    func dismissAllPosts() {
        viewController?.dismissAllPosts()
    }
    
    func dimissPost(_ idx: IndexPath) {
        viewController?.dismissPost(idx)
    }
    
    func displayPostAsRead(_ idx: Int) {
        viewController?.displayPostAsRead(idx)
    }
    
    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }
}

