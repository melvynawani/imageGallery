//
//  ImageManager.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation

protocol ImageManagerType {
   func getImages(for url: String) async throws -> Data
}

class ImageManager: ImageManagerType {
    
    private let networkManager: Networkable
    private let imageCacher: ImageCacher
    init(networkManager:Networkable, imageCacher:ImageCacher = ImageCacher.shared) {
        self.networkManager = networkManager
        self.imageCacher = imageCacher
    }
    

    func getImages(for url: String) async throws -> Data {
        
        if let cachedData = imageCacher.getImage(url: url) {
            return cachedData
        }
        
       let  apiRequest = ApiRequest(baseUrl: url, path:"", params: [:])
        
        guard let data = try? await  self.networkManager.get(apiRequest: apiRequest) else {
            throw APIError.invalidData
        }
        
        imageCacher.saveImage(url: url, data: data)
        
        return data
    }
}
