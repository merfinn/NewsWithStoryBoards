//
//  ArticleListViewModel.swift
//  NewsWithStoryboardsTests
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import XCTest
@testable import NewsWithStoryboards

class ArticleListViewModelTests: XCTestCase {
    
    var sut: ArticleListViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = ArticleListViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_article() {
        // Given
        mockAPIService.completeArticles = [Article]()
        
        // When
        sut.initFetch()
        
        // Assert
        XCTAssert(mockAPIService!.isFetchArticlesCalled)
    }
    
    func test_fetch_articles_fail() {
        
        // Given a failed fetch with a certain failure
        let error = APIError.permissionDenied
        
        // When
        sut.initFetch()
        
        mockAPIService.fetchFail(error: error )
        
        // Sut should display predefined error message
        XCTAssertEqual( sut.alertMessage, error.rawValue )
        
    }
    
    func test_create_cell_view_model() {
        // Given
        let articles = StubGenerator().stubArticles()
        mockAPIService.completeArticles = articles
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableViewClosure = { () in
            expect.fulfill()
        }
        
        // When
        sut.initFetch()
        mockAPIService.fetchSuccess()
        
        // Number of cell view model is equal to the number of articles
        XCTAssertEqual( sut.numberOfCells, articles.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }
    
    func test_loading_when_fetching() {
        
        //Given
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        sut.updateLoadingStatus = { [weak sut] in
            loadingStatus = sut!.isLoading
            expect.fulfill()
        }
        
        //when fetching
        sut.initFetch()
        
        // Assert
        XCTAssertTrue( loadingStatus )
        
        // When finished fetching
        mockAPIService!.fetchSuccess()
        XCTAssertFalse( loadingStatus )
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func test_user_press_item() {
        //Given a sut with fetched articles
        let indexPath = IndexPath(row: 0, section: 0)
        goToFetchArticleFinished()
        
        //When
        sut.userPressed( at: indexPath )
        
        //Assert
        XCTAssertNotNil( sut.selectedArticle )
    }
    
    func test_get_cell_view_model() {
        
        //Given a sut with fetched articles
        goToFetchArticleFinished()
        
        let indexPath = IndexPath(row: 1, section: 0)
        let testArticle = mockAPIService.completeArticles[indexPath.row]
        
        // When
        let vm = sut.getCellViewModel(at: indexPath)
        
        //Assert
        XCTAssertEqual( vm.titleText, testArticle.title)
        
    }
    
    func test_cell_view_model() {
        //Given articles
        let day = "2019-12-19T12:26:00Z"
        
        let article = Article(author: "author", title: "title" , description: "desc" , url: "url", urlToImage: "url", publishedAt:day, content: "content", source: Source(id: "id", name: "name"))
        let articleWithoutDesc = Article(author: "author", title: "title" , description: nil , url: "url", urlToImage: "url", publishedAt:day, content: "content", source: Source(id: "id", name: "name"))
        let articleWithoutTitle = Article(author: "author", title: nil , description: "desc" , url: "url", urlToImage: "url", publishedAt:day, content: "content", source: Source(id: "id", name: "name"))
        let articleWithoutTitleAndDesc = Article(author: "author", title: nil , description: nil , url: "url", urlToImage: "url", publishedAt:day, content: "content", source: Source(id: "id", name: "name"))
        let articleWithoutDate = Article(author: "author", title: "title" , description: "desc" , url: "url", urlToImage: "url", publishedAt:nil, content: "content", source: Source(id: "id", name: "name"))
        let articleWithoutArth = Article(author: nil, title: "title" , description: "desc" , url: "url", urlToImage: "url", publishedAt:day, content: "content", source: Source(id: "id", name: "name"))
        let articleWithoutArthAndDate = Article(author: nil, title: "title" , description: "desc" , url: "url", urlToImage: "url", publishedAt:nil, content: "content", source: Source(id: "id", name: "name"))

        
        // When creat cell view model
        let cellViewModel = sut!.createCellViewModel( article: article )
        let cellViewModelWithoutTitle = sut!.createCellViewModel( article: articleWithoutTitle)
        let cellViewModelWithoutDesc = sut!.createCellViewModel( article: articleWithoutDesc )
        let cellViewModelWithoutTitleAndDesc = sut!.createCellViewModel( article: articleWithoutTitleAndDesc)
        let cellViewModelWithoutDate = sut!.createCellViewModel( article: articleWithoutDate)
        let cellViewModelWithoutArth = sut!.createCellViewModel( article: articleWithoutArth)
        let cellViewModelWithoutArthAndDate = sut!.createCellViewModel( article: articleWithoutArthAndDate)

        XCTAssertEqual(article.title, cellViewModel.titleText)
        XCTAssertEqual( cellViewModel.dateAuthorText , "2019.12.19 , author")

        XCTAssertEqual(article.urlToImage, cellViewModel.imageUrl)
        
        XCTAssertEqual(article.description, cellViewModel.descText)
        XCTAssertEqual(articleWithoutDesc.description, cellViewModelWithoutDesc.descText )
        
        XCTAssertEqual(articleWithoutTitle.description, cellViewModelWithoutTitle.descText)
        XCTAssertEqual(articleWithoutTitleAndDesc.description, cellViewModelWithoutTitleAndDesc.descText)
        
        XCTAssertEqual(cellViewModelWithoutArthAndDate.dateAuthorText, "")
        XCTAssertEqual(cellViewModelWithoutArth.dateAuthorText, "2019.12.19")
        XCTAssertEqual(cellViewModelWithoutDate.dateAuthorText, "author")

    }
}

//MARK: State control
extension ArticleListViewModelTests {
    private func goToFetchArticleFinished() {
        mockAPIService.completeArticles = StubGenerator().stubArticles()
        sut.initFetch()
        mockAPIService.fetchSuccess()
    }
}

class MockApiService: APIServiceProtocol {
    
    var isFetchArticlesCalled = false
    
    var completeArticles: [Article] = [Article]()
    var completeClosure: ((Bool, [Article], APIError?) -> ())!
    
    
    func fetchArticles(complete: @escaping (Bool, [Article], APIError?) -> ()) {
        isFetchArticlesCalled = true
        completeClosure = complete
    }
    
    func fetchSuccess() {
        completeClosure( true, completeArticles, nil )
    }
    
    func fetchFail(error: APIError?) {
        completeClosure( false, completeArticles, error )
    }
}

class StubGenerator {
    func stubArticles() -> [Article] {
        let path = Bundle.main.path(forResource: "content", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let articles = try! decoder.decode(Articles.self, from: data)
        return articles.articles
    }
}
