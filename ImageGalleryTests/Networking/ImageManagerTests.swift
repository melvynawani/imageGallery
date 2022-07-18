//
//  ImageManagerTests.swift
//  ImageGalleryTests
//
//  Created by Melvyn Awani on 15/07/2022.
//

import XCTest
@testable import ImageGallery

class ImageManagerTests: XCTestCase {

    var imageManager:ImageManager!
    let networkManager = MockImageNetworkManager()

    override func setUpWithError() throws {
      imageManager = ImageManager(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
      imageManager = nil
    }
    
    
    func testDownloadImageWithValidUrl() async{
        let imageData = try? await imageManager.getImages(for:"valid")
        
        XCTAssertNotNil(imageData)
    }
    
    func testDownloadImageWithInValidUrl() async{
        
        do {
            _ = try await imageManager.getImages(for:"Invalid")
        }catch {
            XCTAssertEqual(error as! APIError, .invalidData)
            
            XCTAssertEqual((error as! APIError).localizedDescription, "Invalid Data")
        }
        
    }
    
    // Testing Image Cacher
    func testReadImageFromCachingWhenSearchedMoreThanOnce()async {
        
        // GIVEN: gallery viewModel with some photoReoCords
        
        // When : first time search
        let _ = try? await imageManager.getImages(for:"valid")

        // Then : seacond time search should return from cache
        
        let data = try? await imageManager.getImages(for:"valid")

        let imageCacher = ImageCacher.shared
        
        let cachedData = imageCacher.getImage(url: "valid")
        
        // Then
        XCTAssertNotNil(data)
        XCTAssertEqual(data, cachedData) // cached data will be equal to retervied data
    }
    
}
