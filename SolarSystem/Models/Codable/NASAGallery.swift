//
//  NASAGallery.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

enum ImageState {
    case placeholder
    case downloaded
    case failed
}

struct GallerySearchResult: Codable {
    var collection: Collection
    struct Collection: Codable {
        var links: [GalleryLinks]
        var items: [GalleryItems]
    }
}

struct GalleryLinks: Codable {
    var href: String
}

struct GalleryItems: Codable, Equatable {
    static func == (lhs: GalleryItems, rhs: GalleryItems) -> Bool {
        return lhs.href == rhs.href
    }
    
    var href: String?
    var data: [GalleryData]

}

extension GalleryItems {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        href = try values.decodeIfPresent(String.self, forKey: .href)
        data = try values.decode([GalleryData].self, forKey: .data)
    }
}

struct GalleryData {
    var title: String
    var mediaType: String
    var nasaId: String
    var imageURL: URL?
    var image: UIImage?
    var imageState = ImageState.placeholder
    enum CodingKeys: String, CodingKey {
        case title
        case mediaType = "media_type"
        case nasaId = "nasa_id"
    }
}

extension GalleryData: Decodable, Encodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        mediaType = try values.decode(String.self, forKey: .mediaType)
        nasaId = try values.decode(String.self, forKey: .nasaId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(mediaType, forKey: .mediaType)
        try container.encode(nasaId, forKey: .nasaId)
    }
}




















