//
//  MomoxChallangeTests.swift
//  MomoxChallangeTests
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest
@testable import MomoxChallange

class MomoxChallangeTests: XCTestCase {

 var sut: ArticleListViewModel!
        var mockAPIService: MockApiService!
        
        override func setUp() {
            super.setUp()
            mockAPIService = MockApiService()
            sut = ArticleListViewModel()
        }
        
        override func tearDown() {
            sut = nil
            mockAPIService = nil
            super.tearDown()
        }
        
        
        func test_create_view_model_words() {
            // Given
            let words = StubGenerator().stubArticles()()
            mockAPIService.completeWords = words
            
            // When
            sut.initFetch()
           // mockAPIService.fetchSuccess()
            
            XCTAssertNotNil(words)
            
            
        }
    }

    //MARK: State control
    extension ArticleListViewModelTests {
        private func goToFetcedArticlesFinished() {
            mockAPIService.completeWords = StubGenerator().stubArticles()
            sut.initFetch()
           // mockAPIService.fetchSuccess()
        }
    }

    class MockApiService: APIServiceProtocol {
        
        var isFetchCalled = false
        
        var completeWords: Articles = [Word]()
        var completeClosure: ((Bool, Articles, APIError?) -> ())!
        
        func fetchArticles(complete: @escaping (Bool, Articles, APIError?) -> ()) {
            isFetchCalled = true
            completeClosure = complete
        }
        
        func fetchFail(error: APIError?) {
            completeClosure( false, completeWords, error )
        }
    }

    class StubGenerator {
        func stubArticles() -> Articles {
            let path = Bundle.main.path(forResource: "articles", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let words = try! decoder.decode(Articles.self, from: data)
            return words
        }
    }
