//
//  APIService.swift
//  MimiArtistsAndSongs
//
//  Created by merve kavaklioglu on 29.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    /**
     Fetch articles from API
     
     - parameter complete:   A completion block.
     
     */
    func fetchArticles( complete: @escaping ( _ success: Bool, _ articles: [Article], _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    func fetchArticles( complete: @escaping ( _ success: Bool, _ articles: [Article], _ error: APIError? )->() ) {
        
        let newsUrl = URL(string: "https://f7433597-7f68-4fdd-a0df-ce136bf7615f.mock.pstmn.io/news")!
        
        Webservice().load(with: newsUrl) { ( articles: Articles? , response : URLResponse?, error :Error?) in
            if let articles = articles {
                complete( true, articles.articles, nil )
            }
            else {
                complete( false, [], APIError.noNetwork ) // POC
            }
        }
    }
}
