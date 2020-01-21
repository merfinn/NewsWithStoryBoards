//
//  ArticleListCellViewModel.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import Foundation

struct ArticleListCellViewModel {
    let titleText: String?
    let descText: String?
    let imageUrl: String?
    let dateAuthorText: String?
    let contentText: String?
    let sourceNameText: String?
    var cachedImageData: Data?
}
