//
//  ImageGalleryTests.swift
//  ImageGalleryTests
//
//  Created by Melvyn Awani on 08/06/2022.
//

import XCTest
@testable import ImageGallery

class SearchViewModelTests: XCTestCase {

    var viewModel:SearchViewModel!

    override func setUpWithError() throws {
       
        let networkManager = MockNetworkManager()
        let repository = GalleryRepository(networkManager: networkManager)
        let coordinator = AppCoordinator(navBarController: UINavigationController())
        viewModel = SearchViewModel(imageGalleryRepository: repository, coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // Empty Keyword Testing
    func testSearch_WhenKeyWordIsEmpty() async {

        //GIVEN : Empty Keyword
        let keyword = ""
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)
        
        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.invalidSearch.localizedDescription))
    }
    
    // Nil Keyword Testing
    func testSearch_WhenKeyWordIsNil() async {

        //GIVEN : Empty Keyword
        let keyword:String? = nil
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)
        
        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.invalidSearch.localizedDescription))
    }
    
    // Valid keyword search
    func testSearch_WhenKeyWordIsValid() async {
        
        //GIVEN : Valid Search
        let keyword = "valid_keyword_search_response"
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)

        // Then
        XCTAssertEqual(viewModel.state, .showGalleryView)

    }
    
    func testSearch_MultipleTimesWithSameKeyWord() async {
    
        //GIVEN : Valid Search
        let keyword = "valid_keyword_search_response"
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)

        await viewModel.getGalleryImages(keyword: keyword)

        // Then
        XCTAssertEqual(viewModel.state, .showGalleryView)

    }
    
    func testSearch_InvalidKeyWord() async {
    
        //GIVEN : invalid Search keyword
        let keyword = "invalid_keyword_search_response"
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)
        
        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.emptyRecords.localizedDescription))

    }

    // When response is not as per expected Models
    func testSearch_WhenResponseIsNotValid() async {

        //GIVEN : invalid search response with any valid keyword
        let keyword = "invalid_search_response"
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)
        
        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.jsonParsingFailed.localizedDescription))

    }
}
