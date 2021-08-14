//
//  MainListView.swift
//  RedditApp
//
//  Created by Râmede on 14/08/21.
//

import UIKit

final class MainListView: UIView {

    private var redditPosts = ["one", "two", "three", "four"]

    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 26.0)
        label.text = "Reddit Posts"
        return label
    }()
    
    private var redditPostsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RedditPostTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.backgroundColor = .systemGray6
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
        headerView.addSubview(titleLabel)
        addSubview(headerView)
        addSubview(redditPostsTableView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 60),
            headerView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: leftAnchor),
            headerView.bottomAnchor.constraint(equalTo: redditPostsTableView.topAnchor),
            headerView.rightAnchor.constraint(equalTo: rightAnchor),

            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),

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
        //cell?.label.text  = redditPosts[indexPath.row]
        return cell!
    }
}

extension MainListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //delegate?.didSelectPost(redditPosts[indexPath.row])
    }
}
