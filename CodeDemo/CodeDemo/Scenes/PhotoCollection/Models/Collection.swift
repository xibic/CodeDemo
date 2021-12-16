//
//  Collection.swift
//

import Foundation

// MARK: - Collection
struct Collection: Codable {
    let page, perPage: Int
    let media: [Media]
    let totalResults: Int
    let id: String

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case media
        case totalResults = "total_results"
        case id
    }
}
