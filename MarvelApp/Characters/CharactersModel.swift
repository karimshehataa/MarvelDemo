//
//  CharactersModel.swift
//  
//
//  Created by karim  on 24/12/2023.
//

import Foundation

// MARK: - CharactersModel
struct CharactersModel: Codable,GenericResponse {
    var code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataResults?
    
   
}

// MARK: - DataClass
struct DataResults: Codable {
    let offset, limit, total, count: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name, description: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: CategoriesModel?
    let stories: CategoriesModel?
    let events: CategoriesModel?
    let urls: [URLElement]?
}

// MARK: - Comics
struct CategoriesModel: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CategoryItem]?
    let returned: Int?
}

// MARK: - ComicsItem
struct CategoryItem: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: ItemType?
}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: Extension?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType?
    let url: String?
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
