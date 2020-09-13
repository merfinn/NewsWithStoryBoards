//
//  APIServiceTests.swift
//  NewsWithStoryboardsTests
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest
@testable import NewsWithStoryboards

class APIServiceTests: XCTestCase {
    
    var sut: APIService?
    
    override func setUp() {
        super.setUp()
        sut = APIService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetch_articles() {
        
        // Given A apiservice
        let sut = self.sut!
        
        // When fetch articles
        let expect = XCTestExpectation(description: "callback")
        sut.fetchArticles(complete: { (success, articles, error) in
            expect.fulfill()
            XCTAssertGreaterThan( articles.articles.count, 0)
            for article in articles.articles {
                //XCTAssertNotNil(article.source.id) //API Turns a lot of nil :)
                XCTAssertNotNil(article.source)
            }
        })
        wait(for: [expect], timeout: 3.1)
    }
    
}
