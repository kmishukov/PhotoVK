//
//  Response.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 10/06/2018.
//  Copyright © 2018 MyCompany. All rights reserved.


import Foundation

// MARK: friends.GET - Response Structure

struct GetFriendsObject: Codable {
    let response: GetFriendsResponse?
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(GetFriendsResponse.self, forKey: .response)
    }
}

struct GetFriendsResponse: Codable {
    let count: Int?
    let items: [Friend]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        items = try values.decodeIfPresent([Friend].self, forKey: .items)
    }
}

struct Friend: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let photo_100: String?
    let online: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case photo_100 = "photo_100"
        case online = "online"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        photo_100 = try values.decodeIfPresent(String.self, forKey: .photo_100)
        online = try values.decodeIfPresent(Int.self, forKey: .online)
    }
}

// MARK: photos.GET - Response Structures

struct GetProfilePhotosObject: Codable {
    let response: GetProfilePhotosResponse?
    let error: vkError?
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
        case error = "error"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent(GetProfilePhotosResponse.self, forKey: .response)
        error = try values.decodeIfPresent(vkError.self, forKey: .error)
    }
}

struct vkError: Codable {
    let error_code: Int?
    let error_msg: String?
    
    enum CodingKeys: String, CodingKey {
        case error_code = "error_code"
        case error_msg = "error_msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error_code = try values.decodeIfPresent(Int.self, forKey: .error_code)
        error_msg = try values.decodeIfPresent(String.self, forKey: .error_msg)
    }
}

struct GetProfilePhotosResponse: Codable {
    let count: Int?
    let items: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        items = try values.decodeIfPresent([Photo].self, forKey: .items)
    }
}

struct Photo: Codable {
    let id: Int?
    let album_id: Int?
    let owner_id: Int?
    let sizes: [Size]?
    let text: String?
    let date: Double?
    let post_id: Int?
    let likes: Likes?
    let reposts: Reposts?
    let comments: Comments?
    let can_comment: Int?
    let tags: Tags?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case album_id = "album_id"
        case owner_id = "owner_id"
        case sizes = "sizes"
        case text = "text"
        case date = "date"
        case post_id = "post_id"
        case likes = "likes"
        case reposts = "reposts"
        case comments = "comments"
        case can_comment = "can_comment"
        case tags = "tags"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        album_id = try values.decodeIfPresent(Int.self, forKey: .album_id)
        owner_id = try values.decodeIfPresent(Int.self, forKey: .owner_id)
        sizes = try values.decodeIfPresent([Size].self, forKey: .sizes)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        date = try values.decodeIfPresent(Double.self, forKey: .date)
        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
        likes = try values.decodeIfPresent(Likes.self, forKey: .likes)
        reposts = try values.decodeIfPresent(Reposts.self, forKey: .reposts)
        comments = try values.decodeIfPresent(Comments.self, forKey: .comments)
        can_comment = try values.decodeIfPresent(Int.self, forKey: .can_comment)
        tags = try values.decodeIfPresent(Tags.self, forKey: .tags)
    }
}

struct Likes: Codable {
    let user_likes: Int?
    let count: Int?
    
    enum CodingKeys: String, CodingKey {
        case user_likes = "user_likes"
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_likes = try values.decodeIfPresent(Int.self, forKey: .user_likes)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
}

struct Reposts: Codable {
    let count: Int?
    
    enum CodinkKeys: String, CodingKey {
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
}

struct Comments: Codable {
    let count: Int?
    
    enum CodinkKeys: String, CodingKey {
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
}

struct Tags: Codable {
    let count: Int?
    
    enum CodinkKeys: String, CodingKey {
        case count = "count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }
}


struct Size: Codable {
    let type: String?
    let url: String?
    let width: Int?
    let height: Int?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
        case width = "width"
        case height = "height"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        url = try values.decode(String.self, forKey: .url)
        width = try values.decode(Int.self, forKey: .width)
        height = try values.decode(Int.self, forKey: .height)
    }
}
