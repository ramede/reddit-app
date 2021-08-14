//
//  Result.swift
//  RedditApp
//
//  Created by Râmede on 13/08/21.
//

import Foundation

struct RedditPostsResponse: Decodable {
    let kind: String
    let data: RedditListingPage
}

struct RedditListingPage: Codable {
    let after: String
}
