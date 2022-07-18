//
//  FakeImageManager.swift
//  ImageGalleryTests
//
//  Created by Melvyn Awani on 15/07/2022.
//

import Foundation
@testable import ImageGallery

class FakeImageManager: ImageManagerType {
    
    func getImages(for url: String) async throws -> Data {
        if url == "valid" {
           return Data()
        }else {
            throw APIError.invalidData
        }
    }
}
