//
//  MainListView.swift
//  RedditApp
//
//  Created by Râmede on 14/08/21.
//

import UIKit

protocol  MainListViewDelegate: AnyObject {
    func didSelectPost(_ item: RedditChildreen)
    func didPullToRefresh()
    }

final class MainListView: UIView {
    private let refreshControl = UIRefreshControl()
    
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

    private var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()

    private var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private var dismissLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16.0)
        label.text = "Dismiss All"
        label.textAlignment = .center
        return label
    }()
    
    weak var delegate: MainListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGestures()
        setupTableView()
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    var dataSource: [RedditChildreen] = [] {
        didSet {
            DispatchQueue.main.async {
                self.redditPostsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func setupTableView() {
        redditPostsTableView.dataSource = self
        redditPostsTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        redditPostsTableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        delegate?.didPullToRefresh()
    }
    private func buildHierarchy() {
        headerView.addSubview(titleLabel)
        bottomView.addSubview(dismissLabel)
        addSubview(headerView)
        addSubview(redditPostsTableView)
        addSubview(dividerView)
        addSubview(bottomView)
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
            redditPostsTableView.rightAnchor.constraint(equalTo: rightAnchor),
            
            dividerView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            dividerView.rightAnchor.constraint(equalTo: rightAnchor),
            dividerView.leftAnchor.constraint(equalTo: leftAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            bottomView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 40),
            
            dismissLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            dismissLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            dismissLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
        ])
    }
    
    private func setupGestures() {
        let dimissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAllAction))
        bottomView.addGestureRecognizer(dimissGesture)
    }

    @objc
    private func dismissAllAction() {
        dataSource = []
        redditPostsTableView.reloadData()
    }

}

extension MainListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
        ) as? RedditPostTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.author = dataSource[indexPath.row].data.author
        cell.comments = dataSource[indexPath.row].data.comments
        cell.didRead = dataSource[indexPath.row].didRead ?? false
        return cell
    }
}

extension MainListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectPost(dataSource[indexPath.row])
        dataSource[indexPath.row].didRead = true
        redditPostsTableView.reloadData()
    }
}

extension MainListView: RedditPostTableViewCellDelegate {
    func didTapOnDismiss(cell: RedditPostTableViewCell) {
        if let indexPath = redditPostsTableView.indexPath(for: cell) {
            dataSource.remove(at: indexPath.row)
            redditPostsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
