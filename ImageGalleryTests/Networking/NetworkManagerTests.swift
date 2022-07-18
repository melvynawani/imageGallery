//
//  NetworkManagerTests.swift
//  ImageGalleryTests
//
//  Created by Melvyn Awani on 15/07/2022.
//

import XCTest
@testable import ImageGallery

class NetworkManagerTests: XCTestCase {

    var netowkrManager: NetworkManager!
    override func setUpWithError() throws {
        netowkrManager = NetworkManager()
    }

    override func tearDownWithError() throws {
       netowkrManager = nil
    }
    
    // When base URL is empty
    func testInvalidRequest() async {
        // GIVEN
        let request = ApiRequest(baseUrl:"", path:"", params: [:])
        
        do {
          let _ =  try await netowkrManager.get(apiRequest: request)

        }catch {
            XCTAssertEqual(error as! APIError, .requestFailed)
            XCTAssertEqual((error as! APIError).localizedDescription, "Request Failed")
        }
    }
}

