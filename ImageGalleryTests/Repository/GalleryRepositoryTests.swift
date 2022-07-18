//
//  GalleryRepositoryTests.swift
//  ImageGalleryTests
//
//  Created by Melvyn Awani on 15/07/2022.
//

import XCTest
@testable import ImageGallery

class GalleryRepositoryTests: XCTestCase {

    var galleryRepository: GalleryRepository!
    let networkManager = MockNetworkManager()

    override func setUpWithError() throws {
        galleryRepository = GalleryRepository(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
       galleryRepository = nil
    }
    
    
    // When api returns succesfull response
    func testSearch_WhenResponseIsValid() async {
        
        //GIVEN : invalid search response with any valid keyword
        let keyword = "valid_keyword_search_response"
        
        // When
      
           let photoRecords  = try? await galleryRepository.getImages(for: keyword)

        XCTAssertEqual(photoRecords?.count,  20)
    }
    
    
    // When same keyworkd is searched more than once than repository read from cache
    func testSearch_WhenResponseIsReadFromCache() async {
        
        //GIVEN : invalid search response with any valid keyword
        let keyword = "valid_keyword_search_response"
        
        // When
      
        // First time Search
        let _  = try? await galleryRepository.getImages(for: keyword)

        // 2nd time Search with same keyword

        let photoRecords  = try? await galleryRepository.getImages(for: keyword)

        
        XCTAssertEqual(photoRecords?.count,  20)
    }
    
    // When response is not as per expected Modals so json parsign fail
    func testSearch_WhenJsonParsingFails() async {
        
        //GIVEN : invalid search response with any valid keyword
        let keyword = "invalid_search_response"
        
        // When
        do {
           let _ = try await galleryRepository.getImages(for: keyword)

        }catch {
            XCTAssertEqual(error as! APIError, APIError.jsonParsingFailed)
            
            XCTAssertEqual((error as! APIError).localizedDescription, "JSON Parsing Failed")

        }
        
    }
    
    // When response is Empty
    func testSearch_WhenResponseIsEmpty() async {
        
        //GIVEN : When response is empty in json
        let keyword = "invalid_keyword_search_response"
        
        // When
        do {
           let _ = try await galleryRepository.getImages(for: keyword)

        }catch {
            XCTAssertEqual(error as! APIError, APIError.emptyRecords)
            
            XCTAssertEqual((error as! APIError).localizedDescription, "Empty response")

        }
        
    }
    
    // When response is invalid
    func testSearch_WhenResponseIsInvalid() async {
        
        //GIVEN : When response is empty in json
        let keyword = "invalid_keyword"
        
        // When
        do {
           let _ = try await galleryRepository.getImages(for: keyword)

        }catch {
            XCTAssertEqual(error as! APIError, APIError.invalidData)
            
            XCTAssertEqual((error as! APIError).localizedDescription, "Invalid Data")

        }
        
    }
}
