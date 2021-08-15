//
//  MainListPresenter.swift
//  RedditApp
//
//  Created by Râmede on 15/08/21.
//

import UIKit

protocol MainListPresentable: AnyObject {
    var viewController: MainListDisplayable? { get set }
    func presentPosts(_ posts: [RedditChildreen])
    func presentNextPostsPage(_ posts: [RedditChildreen])
    func presentLoading(_ isLoading: Bool)
    func presentError()
}

final class MainListPresenter {
    weak var viewController: MainListDisplayable?
}

extension MainListPresenter: MainListPresentable {
    func presentPosts(_ posts: [RedditChildreen]) {
        viewController?.displayPosts(posts)
    }

    func presentNextPostsPage(_ posts: [RedditChildreen]) {
        viewController?.displayNextPostsPage(posts)
    }

    func presentLoading(_ isLoading: Bool) {
        
    }
    
    func presentError() {
        
    }
}

