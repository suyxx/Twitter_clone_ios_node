//
//  Tweet.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 16/02/23.
//


import Foundation

// MARK: - Welcome
struct Tweet: Codable, Identifiable {
    let id, text, user, username: String
    let userID: String
    let likes: [String]
    let createdAt, updatedAt: String
    let v: Int
    let image: String?
    var didLike: Bool? = false
    

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text, user, username
        case userID = "userId"
        case likes, createdAt, updatedAt, didLike
        case v = "__v"
        case image
    }
}








