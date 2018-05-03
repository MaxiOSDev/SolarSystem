//
//  NASAClient.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation


class NASAClient: APIClient {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // APICall methods.
    
    // This one uses the "inputText" from the textField.
    func search(withTerm term: String, completion: @escaping (Result<GallerySearchResult, APIError>) -> Void) {
        let endpoint = Gallery.search(term: term)
        let request = endpoint.request
        print("Request: \(request)")
        fetch(with: request, decode: { (json) -> GallerySearchResult? in
            guard let results = json as? GallerySearchResult else { return nil }
            
            return results
        }, completion: completion)
    }
    
    // This one is for parsing the collection.json URL within the JSON, so I can end up at the image URL.
    func itemWith(link: GalleryItems, completion: @escaping (Result<[String], APIError>) -> Void) {

        guard let href = link.href else { return }
        
        guard let url = URL(string: href) else { return }
        for data in link.data {
            if data.mediaType == "video" || data.mediaType == "image" {
                let request = URLRequest(url: url)
                
                fetch(with: request, decode: { (json) -> [String]? in
                    guard let results = json as? [String] else { return nil }
                    return results
                }, completion: completion)
            }
        }
    }
    
    // Not used but will be.
    func parseNextPage(with link: [GalleryLinks], completion: @escaping (Result<GallerySearchResult, APIError>) -> Void) {
        for url in link {
            let endpoint = Gallery.page(link: URL(string: url.href)!)
            let request = endpoint.request
            fetch(with: request, decode: { (json) -> GallerySearchResult? in
                guard let results = json as? GallerySearchResult else { return nil }
                return results
            }, completion: completion)
        }

    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}





