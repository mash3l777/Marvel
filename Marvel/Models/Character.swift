//
//  Character.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import Foundation

// MARK: - CharacterDataWrapper
struct CharacterDataWrapper: Codable {
    let code : Int?
    let message : String?
    let status : String?
    let copyright : String?
    let attributionText : String?
    let data : CharacterDataContainer?
    let etag : String?
}


// MARK: - CharacterDataContainer
struct CharacterDataContainer: Codable {
    let offset, limit, total, count: Int?
    let results: [Character]?
}


// MARK: - Character
struct Character: Codable {
    let id: Int?
    let name:String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics: ComicsDetails?
    let urls: [URLElement]?
    
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType?
    let url: String?
}

// MARK: - URLType
enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
