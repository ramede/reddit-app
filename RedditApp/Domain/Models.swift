//
//  Result.swift
//  RedditApp
//
//  Created by Râmede on 13/08/21.
//

import Foundation

struct RedditPost: Decodable {
    let subreddit: String
    let title: String
    let author: String
    let created: Int
    let imageUrl: String?
    let comments: Int
    
    enum CodingKeys: String, CodingKey {
        case subreddit
        case title
        case author
        case created
        case imageUrl = "url_overridden_by_dest"
        case comments = "num_comments"
    }
}

struct RedditChildren: Decodable {
    var image: Data?
    var didRead: Bool?
    var didFetchImage: Bool?
    let kind: String
    let data: RedditPost
}

struct RedditListingPage: Decodable {
    let after: String
    let dist: Int
    let children: [RedditChildren]
}

struct RedditPostsResponse: Decodable {
    let kind: String
    let data: RedditListingPage
}
