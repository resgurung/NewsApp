//
//  ArticleDetailInteractor.swift
//  NewsAppTests
//
//  Created by Resham gurung on 15/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp

class ArticleDetailInteractorTest: XCTestCase {

    let articleDetailPresenterLogicMock = ArticleDetailPresenterLogicMock()
    
    var sut: ArticleDetailInteractor?
    
    override func setUp() {
        super.setUp()
        
        sut = ArticleDetailInteractor(presenter: articleDetailPresenterLogicMock)
    }

    override func tearDown() {
        
        sut = nil
        
        super.tearDown()
    }

    func test_getArticle_shouldPresentArticle() {
        
        // GIVEN
        let request = ArticleDetailModels.Request() // empty request
        
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
        
        sut?.data = article
        
        // WHEN
        sut?.getArticle(request: request)
        
        // THEN
        XCTAssertTrue(articleDetailPresenterLogicMock.presentArticleWasCalled)
    }
    
    func test_getArticle_shouldPresentError() {
        
        // GIVEN
        let request = ArticleDetailModels.Request() // empty request
        
        // WHEN
        sut?.getArticle(request: request)
        
        // THEN
        XCTAssertTrue(articleDetailPresenterLogicMock.presentErrorWasCalled)
    }

}
