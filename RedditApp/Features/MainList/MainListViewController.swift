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

protocol MainListDisplayable: AnyObject {
    func displayPosts(with posts: [RedditChildreen], after: String?)
    func displayNextPostsPage(with posts: [RedditChildreen], after: String?)
    func displayLoading(_ isLoading: Bool)
    func displayError()
}

class MainListViewController: UIViewController {
    private lazy var contentView = MainListView()
    private let interactor: MainListInteractable

    weak var delegate: MainListViewControllerDelegate?
    
    init(interactor: MainListInteractable) {
      self.interactor = interactor
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildHierarchy()
        buildConstraints()
        contentView.delegate = self
        interactor.loadInitialInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.backgroundColor = .systemGray5
    }
    
    private func buildHierarchy() {
    }
    
    private func buildConstraints() {
    }
}

extension MainListViewController: MainListViewDelegate {
    func didSelectPost(_ item: RedditChildreen) {
        delegate?.didSelectPost(item)
    }
    
    func didPullToRefresh() {
        interactor.getRedditPosts(after: nil)
    }
    
    func fetchNextPage(_ after: String) {
        interactor.getRedditPosts(after: after)
    }
}

extension MainListViewController: MainListDisplayable {
    func displayPosts(with posts: [RedditChildreen], after: String?) {
        contentView.dataSource = posts
        contentView.after = after ?? ""
    }
    
    func displayNextPostsPage(with posts: [RedditChildreen], after: String?) {
        contentView.dataSource.append(contentsOf: posts)
        contentView.after = after ?? ""
    }
    
    func displayLoading(_ isLoading: Bool) {

    }
    
    func displayError() {

    }
}
