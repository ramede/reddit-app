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
    func dismissAllPosts()
    func dismissPost(_ idx: IndexPath)
    func displayPosts(with posts: [RedditChildreen], after: String?)
    func displayNextPostsPage(with posts: [RedditChildreen], after: String?)
    func displayPostAsRead(_ idx: Int)
    func displayLoading(_ isLoading: Bool)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .systemGray5
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func buildHierarchy() {
    }
    
    private func buildConstraints() {
    }
}

extension MainListViewController: MainListViewDelegate {
    func didTapOnDimissAll() {
        interactor.dismissAllPosts()
    }
    
    func didTapOnDimissPost(idx: IndexPath) {
        interactor.dimissPost(idx)
    }
    
    func didSelectPost(item: RedditChildreen, idx: Int) {
        delegate?.didSelectPost(item)
        interactor.displayPostAsRead(idx)

        if
          let detailViewController = delegate as? DetailViewController,
          let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
      

    }
    
    func didPullToRefresh() {
        interactor.getRedditPosts(after: nil)
    }
    
    func fetchNextPage(_ after: String) {
        interactor.getRedditPosts(after: after)
    }
    
    func didTapOnSaveImage(_ image: UIImage) {
        interactor.saveImage(image)
    }
}

extension MainListViewController: MainListDisplayable {
    func dismissAllPosts() {
        contentView.dismissAllPosts()
    }
    
    func dismissPost(_ idx: IndexPath) {
        contentView.dismissPost(on: idx)
    }
    
    func displayPosts(with posts: [RedditChildreen], after: String?) {
        contentView.dataSource = posts
        contentView.after = after ?? ""
    }
    
    func displayNextPostsPage(with posts: [RedditChildreen], after: String?) {
        contentView.dataSource.append(contentsOf: posts)
        contentView.after = after ?? ""
    }
    
    func displayPostAsRead(_ idx: Int) {
        contentView.markPostAsRead(on: idx)
    }
    
    func displayLoading(_ isLoading: Bool) {
        contentView.isLoading = isLoading
    }
}
