//
//  RedditPostTableViewCell.swift
//  RedditApp
//
//  Created by Râmede on 10/08/21.
//

import UIKit

protocol RedditPostTableViewCellDelegate: AnyObject {
    func didTapOnDismiss(cell: RedditPostTableViewCell)
}
 
class RedditPostTableViewCell: UITableViewCell {
  
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
        
    private lazy var topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var readStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "unread")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()

    private lazy var middleContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
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
        label.numberOfLines = 2
        label.font = label.font.withSize(14)
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrowRight")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var bottomContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var dismissContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var dimissImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "delete")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var dimissLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Dimiss Post"
        label.font = label.font.withSize(15)
        return label
    }()

    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.font = label.font.withSize(15)
        return label
    }()
    
    weak var delegate: RedditPostTableViewCellDelegate?
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var comments: Int = 0 {
        didSet {
            switch comments {
            case 0:
                commentsLabel.text = ""
            case 1:
                commentsLabel.text = "\(String(comments)) comment"
            default:
                commentsLabel.text = "\(String(comments)) comments"
            }
        }
    }
    
    var author: String = "" {
        didSet {
            authorLabel.text = author
        }
    }
    
    var didRead: Bool = false {
        didSet {
            readStatusImageView.image = didRead ? UIImage(named: "read") : UIImage(named: "unread")
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        buildHierarchy()
        buildConstraints()
        setupGestures()
    }
    
    private func buildHierarchy() {
        contentView.addSubview(verticalStackView)
        
        topContentView.addSubview(readStatusImageView)
        topContentView.addSubview(authorLabel)

        middleContentView.addSubview(postImageView)
        middleContentView.addSubview(titleLabel)
        middleContentView.addSubview(arrowImageView)
        
        dismissContainerView.addSubview(dimissImageView)
        dismissContainerView.addSubview(dimissLabel)
        
        bottomContentView.addSubview(dismissContainerView)
        bottomContentView.addSubview(commentsLabel)

        verticalStackView.addArrangedSubview(topContentView)
        verticalStackView.addArrangedSubview(middleContentView)
        verticalStackView.addArrangedSubview(bottomContentView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            topContentView.heightAnchor.constraint(equalToConstant: 40),
            
            readStatusImageView.leadingAnchor.constraint(equalTo: topContentView.leadingAnchor, constant: 12),
            readStatusImageView.centerYAnchor.constraint(equalTo: topContentView.centerYAnchor),
            readStatusImageView.heightAnchor.constraint(equalToConstant: 15),
            readStatusImageView.widthAnchor.constraint(equalToConstant: 15),
            
            authorLabel.centerYAnchor.constraint(equalTo: topContentView.centerYAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: readStatusImageView.trailingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: topContentView.trailingAnchor, constant: -12),
            
            middleContentView.heightAnchor.constraint(equalToConstant: 80),
            
            postImageView.leadingAnchor.constraint(equalTo: middleContentView.leadingAnchor, constant: 12),
            postImageView.centerYAnchor.constraint(equalTo: middleContentView.centerYAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 80),
            postImageView.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.centerYAnchor.constraint(equalTo: middleContentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 8),
            
            arrowImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            arrowImageView.trailingAnchor.constraint(equalTo: middleContentView.trailingAnchor, constant: -12),
            arrowImageView.centerYAnchor.constraint(equalTo: middleContentView.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 15),
            arrowImageView.widthAnchor.constraint(equalToConstant: 15),
            
            bottomContentView.heightAnchor.constraint(equalToConstant: 40),
            
            dismissContainerView.heightAnchor.constraint(equalToConstant: 40),
            dismissContainerView.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor, constant: 12),
            
            dimissImageView.leadingAnchor.constraint(equalTo: dismissContainerView.leadingAnchor),
            dimissImageView.centerYAnchor.constraint(equalTo: dismissContainerView.centerYAnchor),
            dimissImageView.heightAnchor.constraint(equalToConstant: 15),
            dimissImageView.widthAnchor.constraint(equalToConstant: 15),
            
            dimissLabel.centerYAnchor.constraint(equalTo: dismissContainerView.centerYAnchor),
            dimissLabel.leadingAnchor.constraint(equalTo: dimissImageView.trailingAnchor, constant: 8),
            dimissLabel.trailingAnchor.constraint(equalTo: dismissContainerView.trailingAnchor),

            commentsLabel.centerYAnchor.constraint(equalTo: bottomContentView.centerYAnchor),
            commentsLabel.leadingAnchor.constraint(equalTo: dismissContainerView.trailingAnchor, constant: 8),
            commentsLabel.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor, constant: -12)
        ])
    }
    
    private func setupGestures() {
        let dimissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        dismissContainerView.addGestureRecognizer(dimissGesture)
    }
    
    @objc
    private func dismissAction() {
        delegate?.didTapOnDismiss(cell: self)
    }
}
