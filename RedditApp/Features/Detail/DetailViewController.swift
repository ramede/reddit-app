//
//  DetailViewController.swift
//  RedditApp
//
//  Created by Râmede on 10/08/21.
//

import UIKit

class DetailViewController: UIViewController {
    private lazy var contentView = DetailView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
    }
}

extension DetailViewController: MainListViewControllerDelegate {
    func didSelectPost(_ item: RedditChildreen) {
        contentView.author = item.data.author
        contentView.title = item.data.title
        contentView.imageData = item.image
    }
}
