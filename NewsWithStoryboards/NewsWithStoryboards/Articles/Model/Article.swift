//
//  File.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import Foundation

/**
* Lightweight list for a Article array
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
}
