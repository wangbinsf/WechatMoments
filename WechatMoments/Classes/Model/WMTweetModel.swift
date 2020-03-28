//
//  WMTweetModel.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation

struct WMTweetModel {
    
    struct Sender: Decodable {
        let username: String
        let nick: String
        let avatar: String
    }
    
    struct Image: Decodable {
        let url: String
    }
    
    struct Comment: Decodable {
        let content: String
        let sender: Sender
    }
    
    let error: String?
    let unknownError: String?
    let content: String?
    let images: [Image]?
    let sender: Sender?
    let comments: [Comment]?
    
}
extension WMTweetModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case content
        case images
        case sender
        case comments
        case error
        case unknownError = "unknown error"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print(container)
        self.error = try container.decodeIfPresent(String.self, forKey: .error)
        self.unknownError = try container.decodeIfPresent(String.self, forKey: .unknownError)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.images = try container.decodeIfPresent([Image].self, forKey: .images)
        self.sender = try container.decodeIfPresent(Sender.self, forKey: .sender)
        self.comments = try container.decodeIfPresent([Comment].self, forKey: .comments)
    }
}