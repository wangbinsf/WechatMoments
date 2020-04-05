//
//  ImageDownLoadTests.swift
//  WechatMomentsTests
//
//  Created by 王宾宾 on 2020/4/5.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import XCTest
@testable import WechatMoments

class ImageDownLoadTests: XCTestCase {
    
    let testUrl = "https://thoughtworks-mobile-2018.herokuapp.com/images/tweets/003.jpeg"
    var imageDownLoader: ImageDownloader?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        imageDownLoader = ImageDownloader()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        imageDownLoader = nil
    }

    /// func downloadImage(with url: URL, completedHandle: @escaping (UIImage?) -> Void)
    func testImageDownload() {
        imageDownLoader!.downloadImage(with: URL(string: testUrl)!) { (image) in
            XCTAssertNotNil(image)
        }
    }

}
