//
//  MainListViewController.swift
//  RedditApp
//
//  Created by Râmede on 10/08/21.
//

import UIKit

protocol MainListViewControllerDelegate: AnyObject {
    func didSelectPost(_ item: RedditChildren)
}

protocol MainListDisplayable: AnyObject {
    func dismissAllPosts()
    func dismissPost(_ idx: IndexPath)
    func displayPosts(with posts: [RedditChildren], after: String?)
    func displayNextPostsPage(with posts: [RedditChildren], after: String?)
    func displayPostAsRead(_ idx: Int)
    func displayLoading(_ isLoading: Bool)
    func displayDownloadedImage(_ image: Data?, on idx: Int)
    func presentSaveImageAllert(_ image: UIImage)
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
    
    // TODO: Move to presenter
    private func showDetail() {
        if let detailViewController = delegate as? DetailViewController,
           let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

extension MainListViewController: MainListViewDelegate {
    func didTapOnDimissAll() {
        interactor.dismissAllPosts()
    }
    
    func didTapOnDimissPost(idx: IndexPath) {
        interactor.dimissPost(idx)
    }
    
    func didSelectPost(item: RedditChildren, idx: Int) {
        delegate?.didSelectPost(item)
        interactor.displayPostAsRead(idx)
        showDetail()
    }
    
    func didPullToRefresh() {
        interactor.getRedditPosts(after: nil)
    }
    
    func fetchNextPage(_ after: String) {
        interactor.getRedditPosts(after: after)
    }
    
    func didTapOnSaveImage(_ image: UIImage) {
        interactor.presentSaveImageAlert(image)
    }

    func fecthImage(from url: String, with idx: Int) {
        interactor.fetchImage(from: url, with: idx)
    }
}

extension MainListViewController: MainListDisplayable {
    func dismissAllPosts() {
        contentView.dismissAllPosts()
    }
    
    func dismissPost(_ idx: IndexPath) {
        contentView.dismissPost(on: idx)
    }
    
    func displayPosts(with posts: [RedditChildren], after: String?) {
        contentView.dataSource = posts
        contentView.after = after ?? ""
    }
    
    func displayNextPostsPage(with posts: [RedditChildren], after: String?) {
        contentView.dataSource.append(contentsOf: posts)
        contentView.after = after ?? ""
    }
    
    func displayPostAsRead(_ idx: Int) {
        contentView.markPostAsRead(on: idx)
    }
    
    func displayLoading(_ isLoading: Bool) {
        contentView.isLoading = isLoading
    }
    
    func displayDownloadedImage(_ image: Data?, on idx: Int) {
        contentView.displayDownloadImage(image, on: idx)
    }
    
    func presentSaveImageAllert(_ image: UIImage) {
        let alert = UIAlertController(title: "Hello!", message: "Do you really want to save this image?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.interactor.saveImage(image)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
