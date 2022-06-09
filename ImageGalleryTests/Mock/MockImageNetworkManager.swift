//
//  MockImageDownloader.swift
//  ImageGalleryTests
//
//  Created by Melvyn on 08/06/22.
//

import Foundation
@testable import ImageGallery

class MockImageNetworkManager: Networkable {
    func get(apiRequest: ApiRequestType) async throws -> Data {
        if apiRequest.baseUrl == "valid" {
           return Data()
        }else {
            throw APIError.invalidData
        }
    }
    
}
