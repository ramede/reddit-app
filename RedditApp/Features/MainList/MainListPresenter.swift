//
//  MainListPresenter.swift
//  RedditApp
//
//  Created by Râmede on 15/08/21.
//

import UIKit

protocol MainListPresentable: AnyObject {
    var viewController: MainListDisplayable? { get set }
    func presentPosts(posts: [RedditChildren], after: String?)
    func presentNextPostsPage(posts: [RedditChildren], after: String?)
    func dismissAllPosts()
    func dimissPost(_ idx: IndexPath)
    func displayPostAsRead(_ idx: Int)
    func presentLoading(_ isLoading: Bool)
    func presentDownloadImage(_ image: Data?, on idx: Int)
    func presentSaveImageAlert(_ image: UIImage)
}

final class MainListPresenter {
    weak var viewController: MainListDisplayable?
}

extension MainListPresenter: MainListPresentable {
    func presentPosts(posts: [RedditChildren], after: String?) {
        viewController?.displayPosts(with: posts, after: after)
    }

    func presentNextPostsPage(posts: [RedditChildren], after: String?) {
        viewController?.displayNextPostsPage(with: posts, after: after)
    }
    
    func dismissAllPosts() {
        viewController?.dismissAllPosts()
    }
    
    func dimissPost(_ idx: IndexPath) {
        guard let viewController = viewController else { return }
        viewController.dismissPost(idx)
    }
    
    func displayPostAsRead(_ idx: Int) {
        viewController?.displayPostAsRead(idx)
    }
    
    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoading(isLoading)
    }
    
    func presentDownloadImage(_ image: Data?, on idx: Int) {
        viewController?.displayDownloadedImage(image, on: idx)
    }
    
    func presentSaveImageAlert(_ image: UIImage)  {
        viewController?.presentSaveImageAllert(image)
    }
}

