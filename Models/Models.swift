//
//  Models.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 11/11/2022.
//

import Foundation
enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let profilePhoto: URL
    let count: UserCount
    let joinDate: Date
    
}
struct UserCount {
    let following: Int
    let followers: Int
    let posts: Int
}
public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUser: [String]
    let owner: User
    
}

struct PostLikes {
    let username: String
    let postIdentifier: String
    
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let like: [CommentLike]
    
}


