//
//  ArticleListCell.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

/**
 * A cell for previewing an Article
 */
class ArticleListCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateAuthorPlaceLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var articleListCellViewModel :ArticleListCellViewModel? {
        didSet {
            titleLabel.text = articleListCellViewModel?.titleText
            descriptionLabel.text = articleListCellViewModel?.descText
            dateAuthorPlaceLabel.text = articleListCellViewModel?.dateAuthorText
            contentLabel.text = articleListCellViewModel?.contentText
            mainImageView?.sd_setImage(with: URL( string: articleListCellViewModel?.imageUrl ?? "" ), completed: nil)
        }
    }
}
