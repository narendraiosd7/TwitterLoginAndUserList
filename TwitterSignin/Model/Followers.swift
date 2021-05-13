//
//  Followers.swift
//  TwitterSignin
//
//  Created by narendra.vadde on 12/05/21.
//

import Foundation

class Followers: Codable {
    let users: [User]?
    let nextCursor: Int?
    let nextCursorStr: String?
    let previousCursor: Int?
    let previousCursorStr: String?

    enum CodingKeys: String, CodingKey {
        case users
        case nextCursor = "next_cursor"
        case nextCursorStr = "next_cursor_str"
        case previousCursor = "previous_cursor"
        case previousCursorStr = "previous_cursor_str"
    }

    init(users: [User]?, nextCursor: Int?, nextCursorStr: String?, previousCursor: Int?, previousCursorStr: String?) {
        self.users = users
        self.nextCursor = nextCursor
        self.nextCursorStr = nextCursorStr
        self.previousCursor = previousCursor
        self.previousCursorStr = previousCursorStr
    }
}
