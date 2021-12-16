//
//  Media.swift
//

import Foundation

// MARK: - Media
struct Media: Codable {
    let type: String
    let id, width, height: Int
    let url: String
    let photographer: String
    let photographerURL: String
    let photographerID: Int
    let avgColor: String
    let src: Src
    let liked: Bool
    let alt: String

    enum CodingKeys: String, CodingKey {
        case type, id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case src, liked, alt
    }
}

// MARK: - Src
struct Src: Codable {
    let original, large2X, large, medium: String
    let small, portrait, landscape, tiny: String

    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }
}
