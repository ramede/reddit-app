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
    
    lazy var redditPostsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RedditPostTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var redditPosts = ["one", "two", "three", "four"]
    
    weak var delegate: MainListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildHierarchy()
        buildConstraints()
        redditPostsTableView.dataSource = self
        redditPostsTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.backgroundColor = .green
    }
    
    private func buildHierarchy() {
        view.addSubview(redditPostsTableView)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            redditPostsTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            redditPostsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            redditPostsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redditPostsTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension MainListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RedditPostTableViewCell
        cell?.label.text  = redditPosts[indexPath.row]
        return cell!
    }
}

extension MainListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectPost(redditPosts[indexPath.row])
    }
}
