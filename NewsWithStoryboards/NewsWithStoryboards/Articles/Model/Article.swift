//
//  File.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import Foundation

/**
* Lightweight lis for a Article array
*/
struct Articles: Codable {
    let articles: [Article]
}

/**
* Lightweight model structure for a Article ready for coding and decoding
*/

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: Source
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
        case source
    }
}
