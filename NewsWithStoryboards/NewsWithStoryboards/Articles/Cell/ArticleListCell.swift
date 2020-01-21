//
//  ArticleListCell.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

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
            
            /* Uses cached data or retrieves Data of the Image*/
            if articleListCellViewModel?.cachedImageData != nil {
                mainImageView.image = UIImage(data: articleListCellViewModel!.cachedImageData!)
            } else {
                if let url = URL( string: articleListCellViewModel?.imageUrl ?? "" ) {
                    APIService.getData(from: url) { (data, response, error) in
                        DispatchQueue.main.async() {    // execute on main thread
                            if let data = data {
                                self.articleListCellViewModel?.cachedImageData = data
                                self.mainImageView.image = UIImage(data: data)
                            }
                        }
                    }
                }
            }
        }
    }
}
