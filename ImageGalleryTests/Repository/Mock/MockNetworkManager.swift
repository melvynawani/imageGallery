//
//  MockNetworkManager.swift
//  ImageGalleryTests
//
//  Created by Melvyn on 08/06/22.
//

import Foundation
@testable import ImageGallery

class MockNetworkManager: Networkable {
    func get(apiRequest: ApiRequestType) async throws -> Data {
        
        let bundle = Bundle(for:MockNetworkManager.self)
        
        guard let url = bundle.url(forResource: apiRequest.params["q"], withExtension:"json"),
              let data = try? Data(contentsOf: url) else {
            throw APIError.invalidData
        }
        return data
    }
    
}
