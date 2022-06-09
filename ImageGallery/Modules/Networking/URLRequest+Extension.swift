//
//  URLRequest+Extension.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation

extension URLRequest {
    static func getURLRequest(for apiRequest:ApiRequestType)-> URLRequest? {
        if let url = URL(string:apiRequest.baseUrl.appending(apiRequest.path)),
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false){
            var queryItems = apiRequest.params.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            queryItems.append(URLQueryItem(name:"key", value: EndPoint.apiKey))
            queryItems.append(URLQueryItem(name:"image_type", value:"photo"))
            urlComponents.queryItems = queryItems
            let urlRequest = URLRequest(url: urlComponents.url!)
            return urlRequest
        } else {
            return nil
        }
    }
}
