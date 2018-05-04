//
//  Endpoint.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation

// How I end up creating my urls with search and for the future, page.
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
        guard let url = urlComponents.url else { fatalError() }
        print("URL!: \(url)")
        return URLRequest(url: url)
    }
}

enum Gallery {
    case search(term: String)
    case page(link: URL?)
}

extension Gallery: Endpoint {
    
    var base: String {
        return "https://images-api.nasa.gov"
    }
    
    var path: String {
        switch self {
        case .search, .page: return "/search"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term):
            return [URLQueryItem(name: "q", value: term)]
        case .page(let link):
            return [URLQueryItem(name: "q", value: link?.absoluteString)]
        }
    }
}

enum RoverEndpoint {
    case rover(name: String)
}

extension RoverEndpoint: Endpoint {
    var base: String {
        return "https://api.nasa.gov"
    }
    
    var path: String {
        switch self {
        case .rover(let name): return "/mars-photos/api/v1/rovers/\(name)/photos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .rover:
        var result = [URLQueryItem]()
        let sol = URLQueryItem(name: "sol", value: "10")
        let API_KEY = URLQueryItem(name: "api_key", value: "FibfgEAUvuS0knr5woA5aNckz4QWk12iB5KHkBKr")
        result.append(sol)
        result.append(API_KEY)
        return result
        }
    }
}

enum EarthImageryEndpoint {
    case search(lon: Double, lat: Double)
}

extension EarthImageryEndpoint: Endpoint {
    var base: String {
        return "https://api.nasa.gov"
    }
    
    var path: String {
        switch self {
        case .search: return "/planetary/earth/imagery/"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let lon, let lat):
            var result = [URLQueryItem]()
            let lon = URLQueryItem(name: "lon", value: "\(lon)")
            let lat = URLQueryItem(name: "lat", value: "\(lat)")
            let apiKey = URLQueryItem(name: "api_key", value: "FibfgEAUvuS0knr5woA5aNckz4QWk12iB5KHkBKr")
            result.append(lon)
            result.append(lat)
            result.append(apiKey)
            return result
        }
    }
    
    
}





