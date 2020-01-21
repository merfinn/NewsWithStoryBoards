//
//  Source.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import Foundation

/**
* Lightweight model structure for a source, ready for coding and decoding
*/
struct Source : Codable {
    let id: String?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
