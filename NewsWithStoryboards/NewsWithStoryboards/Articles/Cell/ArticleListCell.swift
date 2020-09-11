//
//  ArticleListCell.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit
import Foundation
import Combine

/**
* A cell for previewing an Article
*/
class ArticleListCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateAuthorPlaceLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    private var cancellable: AnyCancellable?

    var articleListCellViewModel :ArticleListCellViewModel? {
        didSet {
            titleLabel.text = articleListCellViewModel?.titleText
            descriptionLabel.text = articleListCellViewModel?.descText
            dateAuthorPlaceLabel.text = articleListCellViewModel?.dateAuthorText
            contentLabel.text = articleListCellViewModel?.contentText
            
            cancellable = loadImage(for: (articleListCellViewModel?.imageUrl)!).sink { [unowned self] image in self.showImage(image: image) }
        }
    }
    
    private func showImage(image: UIImage?) {
        mainImageView.image = image
    }

    private func loadImage(for imageUrl: String) -> AnyPublisher<UIImage?, Never> {
        return Just(imageUrl)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            let url = URL(string: imageUrl)!
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }
}
