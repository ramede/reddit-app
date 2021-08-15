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
    func presentLoading(_ isLoading: Bool)
    func presentError()
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

    func presentLoading(_ isLoading: Bool) {
        
    }
    
    func presentError() {
        
    }
}

