//
//  ImageCacheLoaderTest.swift
//  WechatMomentsTests
//
//  Created by 王宾宾 on 2020/4/5.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import XCTest
@testable import WechatMoments

class ImageCacheLoaderTest: XCTestCase {
    
    
    let testImage = UIImage(contentsOfFile: Bundle(for: ImageCacheTest.self).path(forResource: "test01", ofType: "png")!)!
    
    let testImageKey = URL(string: "https://www.baidu.com")!
    
    var imageLoader: ImageCacheLoader?
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        imageLoader = ImageCacheLoader()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        imageLoader = nil
        
        ImageCache.shared.removeImage(for: testImageKey)
        ImageCache.shared.removeDiskImage(for: testImageKey)
    }
    
    /// func saveImage(_ image: UIImage, for url: URL, completed: (() -> Void)? = nil)
    func testSaveImage() {
        XCTAssertNil(ImageCache.shared.image(for: testImageKey))
        XCTAssertNil(ImageCache.shared.retrieveImage(forKey: testImageKey))
        imageLoader!.saveImage(testImage, for: testImageKey, completed: {
            XCTAssertNotNil(ImageCache.shared.image(for: self.testImageKey))
            XCTAssertNotNil(ImageCache.shared.retrieveImage(forKey: self.testImageKey))
        })
    }

    /// func loadImage(with url: URL, completionHandle: @escaping (UIImage?) -> Void)
    func testLoadImage() {
        /// memory
        ImageCache.shared.setImage(testImage, for: testImageKey)
        imageLoader!.loadImage(with: testImageKey) { (image) in
            XCTAssertEqual(image, self.testImage)
        }
        /// disk
        ImageCache.shared.store(image: testImage, forKey: testImageKey) {
            self.imageLoader!.loadImage(with: self.testImageKey) { (image) in
                XCTAssertEqual(image, self.testImage)
            }
        }
    }
}
