//
//  GalleryViewModelTests.swift
//  ImageGalleryTests
//
//  Created by Melvyn Awani on 08/06/2022.
//

import XCTest
@testable import ImageGallery

class GalleryViewModelTests: XCTestCase {
    
    var galleryViewModel: ImageGalleryViewModel!
    
    override func setUpWithError() throws {
        galleryViewModel = ImageGalleryViewModel(imageRecodrs: getFakeImageRecords(), imageManager: ImageManager(networkManager: MockImageNetworkManager()))
    }
    
    override func tearDownWithError() throws {
        galleryViewModel = nil
    }
    
    func testDownloadImageWithValidURL() async {
        
        // GIVEN: gallery viewModel with valid photoRecords url
        
        // When
        let data =   await galleryViewModel.downLoadImage(for: 0)
        
        XCTAssertNotNil(data)
    }
    
    func testDownloadImageWithInValidURL()async {
        
        // GIVEN: gallery viewModel with some invalid photoRecord url
        
        // When
        let data =   await galleryViewModel.downLoadImage(for: 1)
        
        XCTAssertNil(data)
        
    }
    
    // Testing Image Cacher
    func testReadImageFromCachingWhenSearchedMoreThanOnce()async {
        
        // GIVEN: gallery viewModel with some photoReoCords
        
        // When
        let data =   await galleryViewModel.downLoadImage(for: 0)
        
        
        let imageCacher = ImageCacher.shared
        
        let cachedData = imageCacher.getImage(url: "valid")
        
        // Then
        XCTAssertNotNil(data)
        XCTAssertEqual(data, cachedData) // cached data will be equal to retervied data
    }
    
    // Checking counts of records
    func testGetGetNumberOfRecords() {
        let actualRecords = galleryViewModel.numberOfRecords
        let expectedRecords = 2
        
        XCTAssertEqual(expectedRecords, actualRecords)
    }
    
    
    private func getFakeImageRecords()-> [PhotoRecord] {
        return [PhotoRecord(id: 1, previewURL:"valid"), PhotoRecord(id: 2, previewURL:"invalid")]
    }
    
}
