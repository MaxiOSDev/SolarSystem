//
//  Endpoint.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    
    var path: String { get }
    
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        print("URL!: \(url)")
        return URLRequest(url: url)
    }
}

enum Gallery {
    case search(term: String)
    case page(link: URL?)
 //   case collection(mediaType: String, nasaId: String)
}

extension Gallery: Endpoint {
    
    var base: String {
        return "https://images-api.nasa.gov"
    }
    
    var path: String {
        switch self {
        case .search, .page: return "/search"
     //   case .collection(let mediaType, let nasaId): return "/\(mediaType)/\(nasaId)/collection.json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term):
            return [URLQueryItem(name: "q", value: term)]
        case .page(let link):
            return [URLQueryItem(name: "q", value: link?.absoluteString)]
     //   case .collection:
      //      return []
        }
    }
}

//https://images-assets.nasa.gov/video/Space-to-Ground_171_170407/collection.json
//https://images-api.nasa.gov/video/Space-to-Ground_171_170407/collection.json




