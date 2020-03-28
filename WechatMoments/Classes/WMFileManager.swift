//
//  FileManager.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation

struct WMFileManager {
    
    @discardableResult
    static func saveErrorData(_ tweets: [WMTweetModel]) -> Bool {
        let encoder = JSONEncoder()
        let dataSource = try? encoder.encode(tweets)
        guard let data = dataSource else { return false }
        let manager = FileManager()
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let docPath = urlForDocument[0]
        let file = docPath.appendingPathComponent("errorInfo.txt")
        return saveFile(file, data: data)
    }
    
    private static func saveFile(_ file: URL, data: Data) -> Bool {
        var ret = true
        ret = createFile(fileUrl: file)
        if ret {
             try? data.write(to: file)
        } else {
            print("写入失败")
        }
        return ret
    }
    
    private static func createFile(fileUrl: URL) -> Bool {
        let manager = FileManager.default
        let file = fileUrl
        print("文件: \(file)")
        let exist = manager.fileExists(atPath: file.path)
        if !exist {
            let createSuccess = manager.createFile(atPath: file.path,contents:nil,attributes:nil)
            print("文件创建结果: \(createSuccess)")
            return createSuccess
        }
        return exist;
    }
}
