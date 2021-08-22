//
//  MainListView.swift
//  RedditApp
//
//  Created by Râmede on 14/08/21.
//

import UIKit

protocol  MainListViewDelegate: AnyObject {
    func didTapOnDimissAll()
    func didTapOnDimissPost(idx: IndexPath)
    func didSelectPost(item: RedditChildreen, idx: Int)
    func didPullToRefresh()
    func fetchNextPage(_ after: String)
    func didTapOnSaveImage(_ image: UIImage)
    func fecthImage(from url: String, with idx: Int)
}

final class MainListView: UIView {
    private let refreshControl = UIRefreshControl()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .systemBlue
        return activityIndicator
    }()

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
        tableView.register(MainListTableViewCell.self, forCellReuseIdentifier: "cell")
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

    private var dismissContainerView: UIView = {
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
    
    var after: String = ""

    var dataSource: [RedditChildreen] = [] {
        didSet {
            DispatchQueue.main.async {
                self.isLoading = false
                self.redditPostsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.activityIndicator.startAnimating()
                    return
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
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

    func dismissAllPosts() {
        dataSource = []
        redditPostsTableView.reloadData()
    }
    
    func markPostAsRead(on idx: Int) {
        if idx >= dataSource.startIndex && idx < dataSource.endIndex {
            dataSource[idx].didRead = true
            DispatchQueue.main.async() {
                self.redditPostsTableView.reloadData()
            }
        }
    }
    
    func dismissPost(on idx: IndexPath) {
        if idx.row >= dataSource.startIndex && idx.row < dataSource.endIndex {
            dataSource.remove(at: idx.row)
            redditPostsTableView.deleteRows(at: [idx], with: .fade)
        }
    }
    
    func displayDownloadImage(_ image: Data?, on idx: Int) {
        if idx >= dataSource.startIndex && idx < dataSource.endIndex {
            dataSource[idx].image = image
            dataSource[idx].didFetchImage = true
            DispatchQueue.main.async() {
                self.redditPostsTableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        redditPostsTableView.dataSource = self
        redditPostsTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        redditPostsTableView.addSubview(refreshControl)
    }
    
    @objc
    private func refresh() {
        delegate?.didPullToRefresh()
    }
    private func buildHierarchy() {
        headerView.addSubview(titleLabel)
        dismissContainerView.addSubview(dismissLabel)
        
        addSubview(headerView)
        addSubview(redditPostsTableView)
        addSubview(dividerView)
        addSubview(dismissContainerView)
        
        redditPostsTableView.backgroundView = activityIndicator
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
            redditPostsTableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            redditPostsTableView.rightAnchor.constraint(equalTo: rightAnchor),
            
            dividerView.bottomAnchor.constraint(equalTo: dismissContainerView.topAnchor),
            dividerView.rightAnchor.constraint(equalTo: rightAnchor),
            dividerView.leftAnchor.constraint(equalTo: leftAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            dismissContainerView.leftAnchor.constraint(equalTo: leftAnchor),
            dismissContainerView.rightAnchor.constraint(equalTo: rightAnchor),
            dismissContainerView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            dismissContainerView.heightAnchor.constraint(equalToConstant: 40),
            
            dismissLabel.trailingAnchor.constraint(equalTo: dismissContainerView.trailingAnchor),
            dismissLabel.leadingAnchor.constraint(equalTo: dismissContainerView.leadingAnchor),
            dismissLabel.centerYAnchor.constraint(equalTo: dismissContainerView.centerYAnchor)
        ])
    }
    
    private func setupGestures() {
        let dimissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAllAction))
        dismissContainerView.addGestureRecognizer(dimissGesture)
    }

    @objc
    private func dismissAllAction() {
        delegate?.didTapOnDimissAll()
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
        ) as? MainListTableViewCell else { return UITableViewCell() }
                
        cell.delegate = self
        cell.author = dataSource[indexPath.row].data.author
        cell.comments = dataSource[indexPath.row].data.comments
        cell.title = dataSource[indexPath.row].data.title
        cell.created = dataSource[indexPath.row].data.created
        cell.didRead = dataSource[indexPath.row].didRead ?? false
        cell.imageData = dataSource[indexPath.row].image
        
        if let imageUrl = dataSource[indexPath.row].data.imageUrl {
            if dataSource[indexPath.row].didFetchImage == nil ||
               dataSource[indexPath.row].didFetchImage == false {
                delegate?.fecthImage(from: imageUrl, with: indexPath.row)
            }
        }
        
        return cell
    }
}

extension MainListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectPost(item: dataSource[indexPath.row], idx: indexPath.row)
    }
}

extension MainListView: MainListTableViewCellDelegate {
    func didTapOnDismiss(cell: MainListTableViewCell) {
        if let indexPath = redditPostsTableView.indexPath(for: cell) {
            delegate?.didTapOnDimissPost(idx: indexPath)
        }
    }
    
    func didTapOnSaveImage(_ image: UIImage) {
        delegate?.didTapOnSaveImage(image)
    }
}

extension MainListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 {
            guard !isLoading else { return }
            isLoading = true
            delegate?.fetchNextPage(after)
        }
    }
}
