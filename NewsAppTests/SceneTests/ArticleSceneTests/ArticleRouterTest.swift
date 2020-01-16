//
//  ArticleRouterTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 14/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp

class ArticleRouterTest: XCTestCase {

    var window: UIWindow?
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
    }

    override func tearDown() {
        
        window = nil
        
        super.tearDown()
    }
    
    func test_routeToDetail_shouldDisplayArticleDetail() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
            return ArticleTableViewController(coder: coder)
        })
        
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
        
        let nvc = NavigationControllerMock(rootViewController: articleVC)
        
        let bussinessLogicMock = ArticleTVCBussinessLogic()
        
        bussinessLogicMock.responseData = response
        
        articleVC.interactor = bussinessLogicMock
        
        let sut = ArticleRouter(viewController: articleVC)
        
        sut.dataStore = bussinessLogicMock
        
        guard let windowUnwrapped = window else {
            
            XCTFail("Window inisilization failed.")
            
            return
        }
        
        loadView(window: windowUnwrapped, viewController: nvc)
        
        // WHEN
        let indexPath = IndexPath(row: 0, section: 0)
        
        sut.routeToDetail(indexPath: indexPath, animated: false)
        
        // THEN
        XCTAssertEqual(nvc.viewControllers.count, 2)
        
        if let articleDetailController = nvc.pushedViewController as? ArticleDetailViewController {

            XCTAssertEqual(articleDetailController.router?.dataStore?.data.title, article.title)
            XCTAssertEqual(articleDetailController.router?.dataStore?.data.description, article.description)

        } else {

            XCTFail()
        }
    }
    
    func test_routeToDetail_shouldNotDisplayArticleDetailWhenIndexPathIsInvalid() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
            return ArticleTableViewController(coder: coder)
        })
        
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
        
        let nvc = NavigationControllerMock(rootViewController: articleVC)
        
        let bussinessLogicMock = ArticleTVCBussinessLogic()
        
        bussinessLogicMock.responseData = response
        
        articleVC.interactor = bussinessLogicMock
        
        let sut = ArticleRouter(viewController: articleVC)
        
        sut.dataStore = bussinessLogicMock
        
        guard let windowUnwrapped = window else {
            
            XCTFail("Window inisilization failed.")
            
            return
        }
        
        loadView(window: windowUnwrapped, viewController: nvc)
        
        // WHEN
        let indexPath = IndexPath(row: 1, section: 0) // wrong indexPath
        
        sut.routeToDetail(indexPath: indexPath, animated: false)
        
        // THEN
        XCTAssertEqual(nvc.viewControllers.count, 1)
        
        if let _ = nvc.pushedViewController as? ArticleDetailViewController {
            XCTFail()
        }
    }

}
