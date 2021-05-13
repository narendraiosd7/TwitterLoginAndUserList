//
//  Following.swift
//  TwitterSignin
//
//  Created by narendra.vadde on 12/05/21.
//

import Foundation

class Following: Codable {
    let users: [User]?
    let nextCursor: Int?
    let nextCursorStr: String?
    let previousCursor: Int?
    let previousCursorStr: String?
    let totalCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case users
        case nextCursor = "next_cursor"
        case nextCursorStr = "next_cursor_str"
        case previousCursor = "previous_cursor"
        case previousCursorStr = "previous_cursor_str"
        case totalCount = "total_count"
    }
    
    init(users: [User]?, nextCursor: Int?, nextCursorStr: String?, previousCursor: Int?, previousCursorStr: String?, totalCount: Int?) {
        self.users = users
        self.nextCursor = nextCursor
        self.nextCursorStr = nextCursorStr
        self.previousCursor = previousCursor
        self.previousCursorStr = previousCursorStr
        self.totalCount = totalCount
    }
}

class User: Codable {
    let id: Int?
    let idStr, name, screenName, location: String?
    let followersCount, friendsCount: Int?
    let profileImageURL: String?
    let profileImageURLHTTPS: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case idStr = "id_str"
        case name
        case screenName = "screen_name"
        case location
        case followersCount = "followers_count"
        case friendsCount = "friends_count"
        case profileImageURL = "profile_image_url"
        case profileImageURLHTTPS = "profile_image_url_https"
    }
    
    init(id: Int?, idStr: String?, name: String?, screenName: String?, location: String?, followersCount: Int?, friendsCount: Int?, profileImageURL: String?, profileImageURLHTTPS: String?) {
        self.id = id
        self.idStr = idStr
        self.name = name
        self.screenName = screenName
        self.location = location
        self.followersCount = followersCount
        self.friendsCount = friendsCount
        self.profileImageURL = profileImageURL
        self.profileImageURLHTTPS = profileImageURLHTTPS
    }
}
