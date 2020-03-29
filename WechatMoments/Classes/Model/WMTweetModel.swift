//
//  WMTweetModel.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation

struct WMTweetModel {
    
    struct Sender: Codable {
        let username: String
        let nick: String
        let avatar: String
    }
    
    struct Image: Codable {
        let url: String
    }
    
    struct Comment: Codable {
        let content: String
        let sender: Sender
    }
    
    let error: String?
    let unknownError: String?
    let content: String?
    var contentType: ContentType
    let images: [Image]?
    let sender: Sender?
    let comments: [Comment]?
    
}
extension WMTweetModel: Codable {
    
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
        let content = try container.decodeIfPresent(String.self, forKey: .content)
        self.content = content
        let images = try container.decodeIfPresent([Image].self, forKey: .images)
        self.images = images
        self.sender = try container.decodeIfPresent(Sender.self, forKey: .sender)
        self.comments = try container.decodeIfPresent([Comment].self, forKey: .comments)
        self.contentType = .unknowType
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(error, forKey: .error)
        try container.encode(unknownError, forKey: .unknownError)
        try container.encode(content, forKey: .content)
        try container.encode(images, forKey: .images)
        try container.encode(sender, forKey: .sender)
        try container.encode(comments, forKey: .comments)
    }
}
