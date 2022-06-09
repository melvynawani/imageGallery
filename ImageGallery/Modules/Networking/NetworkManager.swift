//
//  NetworkManager.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation

protocol Networkable {
    func get(apiRequest:ApiRequestType) async throws -> Data
}

class NetworkManager: Networkable {
    
    func get(apiRequest: ApiRequestType) async throws -> Data {
        guard let request = URLRequest.getURLRequest(for: apiRequest) else {
            throw APIError.requestFailed
        }
        do {
            let (data, _)  = try await URLSession.shared.data(for: request)
            return data
        }catch {
            throw APIError.invalidData
        }
    }
}
