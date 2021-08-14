//
//  MainListView.swift
//  RedditApp
//
//  Created by Râmede on 14/08/21.
//

import UIKit

final class MainListView: UIView {

    private var redditPosts = ["one", "two", "three", "four"]

    private var redditPostsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RedditPostTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupTableView() {
        redditPostsTableView.dataSource = self
        redditPostsTableView.delegate = self
    }
    
    private func buildHierarchy() {
        addSubview(redditPostsTableView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            redditPostsTableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            redditPostsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            redditPostsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            redditPostsTableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

}

extension MainListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RedditPostTableViewCell
        cell?.label.text  = redditPosts[indexPath.row]
        return cell!
    }
}

extension MainListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //delegate?.didSelectPost(redditPosts[indexPath.row])
    }
}
