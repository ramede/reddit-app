//
//  DetailViewController.swift
//  RedditApp
//
//  Created by Râmede on 10/08/21.
//

import UIKit

class DetailViewController: UIViewController {
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.backgroundColor = .yellow
    }
}

extension DetailViewController: MainListViewControllerDelegate {
    func didSelectPost(_ item: String) {
        label.text = item
    }
}
