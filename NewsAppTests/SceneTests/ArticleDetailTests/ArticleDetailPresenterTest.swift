//
//  ArticleDetailPresenterTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 15/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp

class ArticleDetailPresenterTest: XCTestCase {

    let displayLogicMock = ArticleDetailViewDisplayLogicMock()
    
    var sut: ArticleDetailPresenter?
    
    override func setUp() {
        super.setUp()
        
        sut = ArticleDetailPresenter(viewController: displayLogicMock)
    }

    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }

    func test_presentArticle_shouldDisplayArticle() {
        
        // GIVEN
        let expectation = self.expectation(description: "exp")
        
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
        
        // WHEN
        sut?.presentArticle(response: ArticleDetailModels.Response(article: article))
        
        // THEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(displayLogicMock.displayFetchArticleDetailWasCalled)
    }
    
    func test_presentError_shouldDisplayError() {
        
        // GIVEN
        let expectation = self.expectation(description: "exp")
        
        // WHEN
        sut?.presentError(errorResponse: NetworkError.networkError)
        
        // THEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(displayLogicMock.displayErrorWasCalled)
    }
    
    func test_presentArticle_shouldFormatDisplayArticle() {
        
        // GIVEN
        let expectation = self.expectation(description: "exp")
        
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
        
        // WHEN
        sut?.presentArticle(response: ArticleDetailModels.Response(article: article))
        
        // THEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(displayLogicMock.articleViewModel?.displayedArticle.title, "Impeachment state of play: Democrats lose patience with Nancy Pelosi - CNN")
        XCTAssertEqual(displayLogicMock.articleViewModel?.displayedArticle.description, "Patience with House Speaker Nancy Pelosi has run out -- among Democrats.")
    }
    
    func test_presentError_shouldFormatDisplayedError() {
        
        // GIVEN
        let expectation = self.expectation(description: "exp")
        
        // WHEN
        sut?.presentError(errorResponse: NetworkError.networkError)
        
        // THEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(displayLogicMock.responseError?.title, AppStrings.Error.genericTitle)
    }
}
