//
//  ImageCache.swift
//  WechatMomentsTests
//
//  Created by 王宾宾 on 2020/4/4.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import XCTest
@testable import WechatMoments

class ImageCacheTest: XCTestCase {
    
    let testImage = UIImage(contentsOfFile: Bundle(for: ImageCacheTest.self).path(forResource: "test01", ofType: "png")!)!
    let testImage1 = UIImage(contentsOfFile: Bundle(for: ImageCacheTest.self).path(forResource: "test02", ofType: "png")!)!
    
    let testImageKey = URL(string: "https://www.baidu.com")!
    let testImageKey1 = URL(string: "https://www.baidu.com")!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        ImageCache.shared.removeImage(for: testImageKey)
        ImageCache.shared.removeDiskImage(for: testImageKey)
    }

    func testSharedImageCache() {
        XCTAssertNotNil(ImageCache.shared)
    }

    func testSingleInstance() {
        let add0 = Unmanaged.passUnretained(ImageCache.shared).toOpaque()
        let add1 = Unmanaged.passUnretained(ImageCache.shared).toOpaque()
        XCTAssertEqual(add0, add1)
    }
    
    func testImageCacheContainer() {
        XCTAssertNotNil(ImageCache.shared.imageCache)
    }
    
    func testDecodedImageCacheContainer() {
        XCTAssertNotNil(ImageCache.shared.decodedImageCache)
    }
    
    func testSemaphore() {
        XCTAssertNotNil(ImageCache.shared.semphore)
    }
    
    func testIoQueue() {
        XCTAssertNotNil(ImageCache.shared.ioQueue)
    }
    
    /// func setImage(_ image: UIImage?, for url: URL)
    func testSetImageWithKey() {
        XCTAssertNil(ImageCache.shared.image(for: testImageKey))
        ImageCache.shared.setImage(testImage, for: testImageKey)
        XCTAssertEqual(ImageCache.shared.image(for: testImageKey), testImage)
    }
    
    /// func image(for url: URL) -> UIImage?
    func testGetImageWithKey() {
        ImageCache.shared.setImage(testImage, for: testImageKey)
        XCTAssertEqual(ImageCache.shared.image(for: testImageKey), testImage)
    }
    
    /// func removeImage(for url: URL)
    func testRemoveImageWithKey() {
        ImageCache.shared.setImage(testImage, for: testImageKey)
        ImageCache.shared.removeImage(for: testImageKey)
        XCTAssertNil(ImageCache.shared.image(for: testImageKey))
    }
    
    /// func removeAllImages()
    func testRemoveAllImage() {
        ImageCache.shared.setImage(testImage, for: testImageKey)
        ImageCache.shared.setImage(testImage1, for: testImageKey1)
        ImageCache.shared.removeAllImages()
        XCTAssertNil(ImageCache.shared.image(for: testImageKey))
        XCTAssertNil(ImageCache.shared.image(for: testImageKey1))
    }
    
    /// func store(image: UIImage, forKey key: URL)
    func testStoreImage() {
        XCTAssertNil(ImageCache.shared.retrieveImage(forKey: testImageKey))
        ImageCache.shared.store(image: testImage, forKey: testImageKey) {
            XCTAssertEqual(ImageCache.shared.retrieveImage(forKey: self.testImageKey), self.testImage)
        }
    }
    
    /// func retrieveImage(forKey key: URL) -> UIImage?
    func testRetrieveImage() {
        ImageCache.shared.store(image: testImage, forKey: testImageKey) {
            XCTAssertEqual(ImageCache.shared.retrieveImage(forKey: self.testImageKey), self.testImage)
        }
    }
    
    /// func filePath(forKey key: URL) -> URL?
    func testFilePath() {
        ImageCache.shared.store(image: testImage, forKey: testImageKey) {
            let pathUrl = ImageCache.shared.filePath(forKey: self.testImageKey)
            XCTAssertTrue(FileManager.default.fileExists(atPath: pathUrl!.path))
        }
    }

    /// func diskPath() -> URL?
    func testDiskFilePath() {
        ImageCache.shared.store(image: testImage, forKey: testImageKey) {
            let pathUrl = ImageCache.shared.diskPath()
            XCTAssertTrue(FileManager.default.fileExists(atPath: pathUrl!.path))
        }
    }

}
