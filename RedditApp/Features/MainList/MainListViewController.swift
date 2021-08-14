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
        
        // Build URL
        let api = "https://www.reddit.com"
        let endpoint = "/top/.json?limit=10"
        let url = URL(string: api + endpoint)
        
        // Fetch
        NetworkDispatcher().execute(sessionURL: url!) { (result: Result<RedditPostsResponse, Error>) in
            switch result {
            case .success(let redditPostsResponse):
                self.contentView.dataSource = redditPostsResponse.data.children
                print(redditPostsResponse)
                print("redditPostsResponse")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.backgroundColor = .systemGray5
    }
    
    private func buildHierarchy() {
    }
    
    func buildConstraints() {
    }
}

extension MainListViewController: MainListViewDelegate {
    func didSelectPost(_ item: RedditChildreen) {
        delegate?.didSelectPost(item)
    }
}
