//
//  FakeGalleryRepository.swift
//  ImageGalleryTests
//
//  Created by Melvyn Awani on 15/07/2022.
//

import Foundation
@testable import ImageGallery

class FakeGalleryRepository: ImageGalleryRepositoryType {
    
    private var photoRecords: [PhotoRecord]!
    
    func getImages(for keyWord: String) async throws -> [PhotoRecord] {
        if photoRecords == nil {
            throw APIError.emptyRecords
        }
        return photoRecords
    }
    
    func stubPhotoRecords(photoRecords: [PhotoRecord]) {
        self.photoRecords = photoRecords
    }
}

