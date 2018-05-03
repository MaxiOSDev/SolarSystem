//
//  NASAGallery.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import Foundation
import UIKit

// Wanted to follow/use Pasan's way from ItunesClient.
enum ImageState {
    case placeholder
    case downloaded
    case failed
}
// How the JSON of this api is structured.
struct GallerySearchResult: Codable {
    var collection: Collection
}

struct Collection: Codable {
    var links: [GalleryLinks]
    var items: [GalleryItems]
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
// This class was originally a struct but I could not modify the data within it like in th iTunesClient method that was taught. Out of ideas and brain power.
class GalleryData {
    
    var title: String = ""
    var mediaType: String = ""
    var nasaId: String = ""
    // The following 3 properties stay nil, and do not update. Have no clue what to do now.
    var imageURL: URL? = ImageData.shared.imageURL
    var image: UIImage? = ImageData.shared.image
    var imageState: ImageState? = ImageData.shared.imageState // The idea was to have this as placeholder and then it would become .downloaded once the image is downloaded and set using Nuke.
    enum CodingKeys: String, CodingKey {
        case title
        case mediaType = "media_type"
        case nasaId = "nasa_id"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        mediaType = try values.decode(String.self, forKey: .mediaType)
        nasaId = try values.decode(String.self, forKey: .nasaId)
    }

}

extension GalleryData: Decodable, Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(mediaType, forKey: .mediaType)
        try container.encode(nasaId, forKey: .nasaId)
    }
}




















