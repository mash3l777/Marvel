//
//  Comic.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import UIKit

// MARK: - ComicsDetails
struct ComicsDetails: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
    let returned: Int?
}

// MARK: - ComicSummary
struct ComicSummary: Codable {
    let resourceURI: String?
    let name: String?
}
