//
//  ArticleListViewModel.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import Foundation

class ArticleListViewModel {
    
    let apiService: APIServiceProtocol
    
    private var articles: [Article] = [Article]()
    private var cellViewModels: [ArticleListCellViewModel] = [ArticleListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var selectedArticle: Article?
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        
        apiService.fetchArticles { [weak self] (success, articleList, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.processFetchedArticles(articles: articleList)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ArticleListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( article: Article ) -> ArticleListCellViewModel {
        
        return ArticleListCellViewModel( titleText: article.title,
                                         descText: article.articleDescription, 
                                         imageUrl: article.urlToImage,
                                         dateAuthorText: Utility.publisherFormatter(publishedAt: article.publishedAt, author: article.author),
                                         contentText: article.content,
                                         sourceNameText: article.source?.name
        )
    }
    
    private func processFetchedArticles( articles: [Article] ) {
        self.articles = articles
        var vms = [ArticleListCellViewModel]()
        for article in articles {
            vms.append(createCellViewModel(article: article) )
        }
        self.cellViewModels = vms
    }
}

extension ArticleListViewModel {
    func userPressed( at indexPath: IndexPath ){
        selectedArticle = self.articles[indexPath.row]
    }
}
