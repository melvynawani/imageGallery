//
//  GalleryViewModel.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation

final class ImageGalleryViewModel {

    private let imageRecords:[PhotoRecord]
    private let imageManager: ImageManagerType
    
    var numberOfRecords:Int {
        return imageRecords.count
    }
    
    init(imageRecodrs:[PhotoRecord], imageManager: ImageManagerType) {
        self.imageRecords = imageRecodrs
        self.imageManager = imageManager
    }
    
    func downLoadImage(for index:Int)async -> Data? {
        let url = imageRecords[index].previewURL
      
        return  try? await imageManager.getImages(for: url)
    }
}
