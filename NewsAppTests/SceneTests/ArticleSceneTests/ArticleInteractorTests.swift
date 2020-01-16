//
//  ArticleInteractorTests.swift
//  NewsAppTests
//
//  Created by Resham gurung on 14/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp

class ArticleInteractorTests: XCTestCase {

    let mockArticlePresenterLogic = ArticlePresenterLogicMock()
    
    let articleWorkerMock = ArticleWorkerMock()
    
    var sut: ArticleInteractor?
    
    override func setUp() {
        super.setUp()
        
        sut = ArticleInteractor(presenter: mockArticlePresenterLogic, worker: articleWorkerMock)
    }

    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }
    
    func test_fetchArticles() {
        
        sut?.getArticles(request: ArticleModels.Request())
        
        XCTAssertTrue(articleWorkerMock.fetchWasCalled)
    }
    
    func test_fetchArticles_shouldAskPresenterToPresentError() {
        
        articleWorkerMock.error = NetworkError.unknown
        
        sut?.getArticles(request: ArticleModels.Request())
        
        XCTAssertTrue(mockArticlePresenterLogic.presentErrorWasCalled)
    }
    
    func test_fetchArticles_shouldAskPresenterToPresentData() {
        
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
        
        articleWorkerMock.response = response
        
        sut?.getArticles(request: ArticleModels.Request())
        
        XCTAssertTrue(mockArticlePresenterLogic.presentFetchArticlesWasCalled)
    }
}
