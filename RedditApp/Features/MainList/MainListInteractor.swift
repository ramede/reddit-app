//
//  MainListInteractor.swift
//  RedditApp
//
//  Created by Râmede on 15/08/21.
//

import UIKit

protocol MainListInteractable: AnyObject {
    func loadInitialInfo()
    func getRedditPosts(after: String?)
    func dismissAllPosts()
    func dimissPost(_ idx: IndexPath)
    func displayPostAsRead(_ idx: Int)
    func saveImage(_ image: UIImage)
    func fetchImage(from url: String, with idx: Int)
    func presentSaveImageAlert(_ image: UIImage)
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
        presenter.presentLoading(true)
        
        // TODO: Create a URL Builder
        let pageSize = 5
        let api = "https://www.reddit.com"
        let endpoint = "/top/.json?limit=\(String(pageSize))"
        
        var afterCondicional = ""
        if let after = after {
            afterCondicional = "&after=\(after)"
        }
        let url = URL(string: api + endpoint + afterCondicional)
        
        // TODO: Create services and protocols interfaces to became testable
        NetworkDispatcher().execute(sessionURL: url!) { (result: Result<RedditPostsResponse, Error>) in
            self.presenter.presentLoading(false)
            switch result {
            case .success(let redditPostsResponse):
                self.handleRedditResponse(after: after, with: redditPostsResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func dismissAllPosts() {
        presenter.dismissAllPosts()
    }
    
    func dimissPost(_ idx: IndexPath) {
        presenter.dimissPost(idx)
    }
    
    func displayPostAsRead(_ idx: Int) {
        presenter.displayPostAsRead(idx)
    }
    
    func saveImage(_ image: UIImage) {
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: image)
    }
    
    func fetchImage(from url: String, with idx: Int) {
        // TODO: Create services and protocols interfaces to became testable
        NetworkDispatcher().downloadImage(from: url) { (result: Result<Data?, Error>) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self.presenter.presentDownloadImage(data, on: idx)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func presentSaveImageAlert(_ image: UIImage) {
        presenter.presentSaveImageAlert(image)
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
