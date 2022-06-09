//
//  ImagesResponse.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation

// MARK: - ImagesResponse
struct ImagesResponse: Decodable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let id: Int
    let pageURL: String
    let previewURL: String
    let largeImageURL: String

    enum CodingKeys: String, CodingKey {
        case id, pageURL,  previewURL,  largeImageURL
    }
}
