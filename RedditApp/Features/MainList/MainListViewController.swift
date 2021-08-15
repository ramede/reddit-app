//
//  MainListViewController.swift
//  RedditApp
//
//  Created by Râmede on 10/08/21.
//

import UIKit

protocol MainListViewControllerDelegate: AnyObject {
    func didSelectPost(_ item: RedditChildreen)
}

class MainListViewController: UIViewController {
    private lazy var contentView = MainListView()

    weak var delegate: MainListViewControllerDelegate?
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildHierarchy()
        buildConstraints()
        contentView.delegate = self
        fetchPost()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.backgroundColor = .systemGray5
    }
    
    private func buildHierarchy() {
    }
    
    private func buildConstraints() {
    }
    
    private func fetchPost(after: String? = nil) {
        // Build URL
        let api = "https://www.reddit.com"
        let endpoint = "/top/.json?limit=15"
        
        var afterCondicional = ""
        if let after = after {
            afterCondicional = "&after=\(after)"
        }
        
        let url = URL(string: api + endpoint + afterCondicional)
        
        // Fetch
        NetworkDispatcher().execute(sessionURL: url!) { (result: Result<RedditPostsResponse, Error>) in
            switch result {
            case .success(let redditPostsResponse):
                if let _ = after {
                    self.contentView.dataSource.append(contentsOf: redditPostsResponse.data.children)
                } else {
                    self.contentView.dataSource = redditPostsResponse.data.children
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainListViewController: MainListViewDelegate {
    func didSelectPost(_ item: RedditChildreen) {
        delegate?.didSelectPost(item)
    }
    
    func didPullToRefresh() {
        fetchPost()
    }
    
    func fetchNextPage(_ after: String) {
        fetchPost(after: after)
    }
}
