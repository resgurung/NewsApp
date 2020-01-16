//
//  ArticlePresenterTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 14/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp


class ArticlePresenterTest: XCTestCase {

    
    let displayLogicMock = ArticleViewDisplayLogicMock()
    
    var sut: ArticlePresenter?
    
    override func setUp() {
        super.setUp()
        
        sut = ArticlePresenter(viewController: displayLogicMock)
    }

    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }

    func test_presentFetchArticles_ShouldDisplayArticle() {
     
        let expectation = self.expectation(description: "exp")
        // GIVEN
        let article = Article (
            source: Source(id: "cnn", name: "cnn"),
            author: "Phil Mattingly, CNN",
            title: "Impeachment state of play: Democrats lose patience with Nancy Pelosi - CNN",
            description: "Patience with House Speaker Nancy Pelosi has run out -- among Democrats.",
            url: "https://www.cnn.com/2020/01/09/politics/impeachment-state-of-play/index.html",
            urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/191218210939-14-full-house-impeachment-1218-super-tease.jpg",
            publishedAt: "2020-01-09T15:32:00Z",
            content: nil
        )
        
        let response = ArticleModels.Response (
            status: "ok",
            totalResults: 1,
            articles: [article]
        )
        
        // WHEN
        sut?.presentFetchArticles(response: response) 
        
        // THEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(displayLogicMock.displayFetchArticleWasCalled)
    }
    
    func test_presentFetchArticles_ShouldFormatDisplayedArticle() {
        
        let expectation = self.expectation(description: "exp")
        // GIVEN
        let article = Article (
            source: Source(id: "cnn", name: "cnn"),
            author: "Phil Mattingly, CNN",
            title: "Impeachment state of play: Democrats lose patience with Nancy Pelosi - CNN",
            description: "Patience with House Speaker Nancy Pelosi has run out -- among Democrats.",
            url: "https://www.cnn.com/2020/01/09/politics/impeachment-state-of-play/index.html",
            urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/191218210939-14-full-house-impeachment-1218-super-tease.jpg",
            publishedAt: "2020-01-09T15:32:00Z",
            content: nil
        )
        
        let response = ArticleModels.Response (
            status: "ok",
            totalResults: 1,
            articles: [article]
        )
        
        // WHEN
        sut?.presentFetchArticles(response: response)
        
        // THEN
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)

        XCTAssertEqual(displayLogicMock.articleViewModel?.articles.count, 1)
        XCTAssertEqual(displayLogicMock.articleViewModel?.articles[0].title,"Impeachment state of play: Democrats lose patience with Nancy Pelosi - CNN")
        XCTAssertEqual(displayLogicMock.articleViewModel?.articles[0].description,"Patience with House Speaker Nancy Pelosi has run out -- among Democrats.")
        
    }
    
    
    func test_presentError_ShouldFormatFetchedErrorForDisplay() {
        
        let expectation = self.expectation(description: "exp")
        // WHEN
        sut?.presentError(responseError: NetworkError.networkError)
        
        // THEN
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(displayLogicMock.responseError?.title, AppStrings.Error.genericTitle)
        
    }
    
    func test_presentError_shouldDisplayError() {
        
        let expectation = self.expectation(description: "exp")
        // WHEN
        sut?.presentError(responseError: NetworkError.networkError)
        
        // THEN
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(displayLogicMock.displayErrorWasCalled)
    }

}
