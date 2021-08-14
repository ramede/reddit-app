//
//  Result.swift
//  RedditApp
//
//  Created by Râmede on 13/08/21.
//

import Foundation

struct RedditPost: Decodable {
    let subreddit: String
    let author: String
    let created: Int
    let url: String?
    let comments: Int
    
    enum CodingKeys: String, CodingKey {
        case subreddit
        case author
        case created
        case url = "url_overridden_by_dest"
        case comments = "num_comments"
    }
}

struct RedditChildreen: Decodable {
    let kind: String
    let data: RedditPost
}

struct RedditListingPage: Decodable {
    let after: String
    let dist: Int
    let children: [RedditChildreen]
}

struct RedditPostsResponse: Decodable {
    let kind: String
    let data: RedditListingPage
}
