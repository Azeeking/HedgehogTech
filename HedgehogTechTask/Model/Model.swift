//
//  Model.swift
//  HedgehogTechTask
//
//  Created by Azik on 16.02.2023.
//
import Foundation
import UIKit

// MARK: - ImagesModel
struct Model: Codable {
    let imagesResults: [ImagesResult]

    enum CodingKeys: String, CodingKey {
        case imagesResults = "images_results"
    }
}

// MARK: - ImagesResult
struct ImagesResult: Codable {
    let position: Int
    let thumbnail, original, title: String
    let link: String
    let source: String

    enum CodingKeys: String, CodingKey {
        case position = "position"
        case thumbnail, original, title, link, source
    }
}
