//
//  DetailView.swift
//  RedditApp
//
//  Created by Râmede on 14/08/21.
//

import UIKit

final class DetailView: UIView {    
    private var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 26.0)
        label.text = "Reddit - Dive into anything"
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "reddit")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildHierarchy()
        buildConstraints()
    }
    
    var author: String = "" {
        didSet {
            authorLabel.text = author
        }
    }

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func buildHierarchy() {
        addSubview(authorLabel)
        addSubview(postImageView)
        addSubview(titleLabel)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 36),
            authorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            postImageView.widthAnchor.constraint(equalToConstant: 100),
            postImageView.heightAnchor.constraint(equalToConstant: 100),
            postImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 24),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36)
        ])
    }
}

