//
//  MainListViewController.swift
//  RedditApp
//
//  Created by Râmede on 10/08/21.
//

import UIKit

protocol MainListViewControllerDelegate: AnyObject {
    func didSelectPost(_ item: String)
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
        
        // Build URL
        let api = "https://www.reddit.com"
        let endpoint = "/top/.json?limit=50"
        let url = URL(string: api + endpoint)

        // Fetch
        NetworkDispatcher().execute(sessionURL: url!) { (result: Result<RedditPostsResponse, Error>) in
            print(result)
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
