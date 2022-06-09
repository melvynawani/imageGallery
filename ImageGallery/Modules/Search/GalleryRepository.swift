//
//  GalleryRepository.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation

protocol ImageGalleryRepositoryType {
    func getImages(for keyWord: String) async throws -> [PhotoRecord]
}

class GalleryRepository: ImageGalleryRepositoryType {
    
    private var cachedResult: [String : [PhotoRecord]] = [:]
    
    private let networkManager: Networkable
    
    init(networkManager:Networkable) {
        self.networkManager = networkManager
    }
    
    func getImages(for keyWord: String) async throws -> [PhotoRecord] {
        
        if let cachedRecords = getCachedResponse(for: keyWord) {
            return cachedRecords
        }
        
        let  apiRequest = ApiRequest(baseUrl: EndPoint.baseUrl, path:"", params: ["q": keyWord])
        
        guard let data = try? await  self.networkManager.get(apiRequest: apiRequest) else {
            throw APIError.invalidData
        }
        
        guard let imageRecords = getDecodedResopnse(from: data) else {
            throw APIError.jsonParsingFailed
        }
        if imageRecords.count == 0 {
            throw APIError.emptyRecords
        }
        cachedResult[keyWord] = imageRecords
        return imageRecords
    }
    
    
    private func getCachedResponse(for keyword:String)-> [PhotoRecord]? {
        return cachedResult[keyword]
    }
    
    private func getDecodedResopnse(from data: Data)-> [PhotoRecord]? {
        guard let decodedResponse = try? JSONDecoder().decode(ImagesResponse.self, from: data) else {
            return nil
        }
        
        return decodedResponse.hits.map {
            PhotoRecord(id:$0.id , previewURL: $0.previewURL)
        }
    }
}
