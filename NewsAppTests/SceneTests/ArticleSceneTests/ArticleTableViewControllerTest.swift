//
//  ArticleTableViewControllerTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 14/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp

class ArticleTableViewControllerTest: XCTestCase {

    var window: UIWindow?
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
    }

    override func tearDown() {
        super.tearDown()
        
        window = nil
    }

    func test_init_shouldSetRouter() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
            return ArticleTableViewController(coder: coder)
        })
        
        // THEN
        XCTAssertNotNil(articleVC.router)
    }
    
    func test_init_shouldSetInteractor() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
            return ArticleTableViewController(coder: coder)
        })
        
        // THEN
        XCTAssertNotNil(articleVC.interactor)
    }
    
    func test_init_shouldSetPresenter() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
            return ArticleTableViewController(coder: coder)
        })
        
        // THEN
        if let interactor = articleVC.interactor as? ArticleInteractor, let presenter = interactor.presenter as? ArticlePresenter {
            
            XCTAssertNotNil(presenter.viewController)
        } else {
            
            XCTFail()
        }
    }
    
    func test_init_shouldSetRouterViewController() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
            return ArticleTableViewController(coder: coder)
        })
        
        // THEN
        XCTAssertEqual(articleVC.router?.viewController, articleVC)
    }
    
    func test_viewDidAppearShouldFetchArticles() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let interactor = ArticleTVCBussinessLogic()
        
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
            return ArticleTableViewController(coder: coder)
        })
        
        articleVC.interactor = interactor
        
        guard let w = window else {
            
            XCTFail("Window not set")
            
            return
        }
        
        loadView(window: w, viewController: articleVC)
        
        // THEN
        XCTAssertTrue(interactor.getArticlesWasCalled)
    }
    
    func test_viewDidLoad_shouldSetupTableViewDataSource() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
            return ArticleTableViewController(coder: coder)
        })
       
        guard let w = window else {
           
            XCTFail("Window not set")
           
            return
       }
        
        loadView(window: w, viewController: articleVC)
        
        // THEN
        XCTAssertNotNil(articleVC.tableView.dataSource)
    }
    
    
    func test_viewDidLoad_shouldSetupTableViewDelegate() {
        
        // GIVEN
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
             return ArticleTableViewController(coder: coder)
         })
        
         guard let w = window else {
            
             XCTFail("Window not set")
            
             return
        }
         
         loadView(window: w, viewController: articleVC)
         
         // THEN
        XCTAssertNotNil(articleVC.tableView.delegate)
    }
    
    func test_noOfSection_shouldBeOne() {
        
        // GIVEN
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
             return ArticleTableViewController(coder: coder)
         })
        
        guard let tableView = articleVC.tableView else { return XCTFail("TableView not set.") }
        
        // WHEN
        let numberOfSection = articleVC.numberOfSections(in: tableView)
        
        // THEN
        XCTAssertEqual(numberOfSection, 1)
    }
    
    func test_noOfRowsInSection_shouldBeEqualToArticlesToDisplay() {
        
        // GIVEN
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
             return ArticleTableViewController(coder: coder)
         })
        
        let viewModel = ArticleModels.ViewModel(articles: [ArticleModels.ViewModel.DisplayArticle(title: "", description: "", publishedAt: "", urlToImage: "")])
        
        articleVC.displayFetchedArticles(viewModel: viewModel)
        
        guard let tableView = articleVC.tableView else { return XCTFail("TableView not set.") }
        
        // WHEN
        let numOfRows = articleVC.tableView(tableView, numberOfRowsInSection: 0)
        
        // THEN
        XCTAssertEqual(numOfRows, 1)
    }
    
    func test_cellForRowAtIndexPath_shouldconfigureCellToDisplay() {
        
        let expectation = self.expectation(description: "exp")
        // GIVEN
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
             return ArticleTableViewController(coder: coder)
         })
        
        let viewModel = ArticleModels.ViewModel(articles: [ArticleModels.ViewModel.DisplayArticle(title: "XCTEST", description: "", publishedAt: "", urlToImage: "")])
        
        articleVC.displayFetchedArticles(viewModel: viewModel)
        
        guard let tableView = articleVC.tableView else { return XCTFail("TableView not set.") }
        
        guard let w = window else {
            
             XCTFail("Window not set")
            
             return
        }
        
        // When

        loadView(window: w, viewController: articleVC)
        
        // THEN
        let indexPath = IndexPath(row: 0, section: 0)
        
        let cell = articleVC.tableView(tableView, cellForRowAt: indexPath)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(cell.textLabel?.text, "XCTEST")
        
    }
    
    func test_didSelectRow_shouldNavigateToDetail() {
        
        // GIVEN
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
         let articleVC = storyboard.instantiateViewController(identifier: "ArticleTableViewController", creator: { coder in
             return ArticleTableViewController(coder: coder)
         })
        let routing = ArticleRouterMock()
        
        articleVC.router = routing
        
        let viewModel = ArticleModels.ViewModel(articles: [ArticleModels.ViewModel.DisplayArticle(title: "XCTEST", description: "", publishedAt: "", urlToImage: "")])
        
        articleVC.displayFetchedArticles(viewModel: viewModel)
        
        guard let tableView = articleVC.tableView else { return XCTFail("TableView not set.") }
        
        guard let w = window else {
            
             XCTFail("Window not set")
            
             return
        }
        
        // When

        loadView(window: w, viewController: articleVC)
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        articleVC.tableView(tableView, didSelectRowAt: indexPath)
        
        // THEN
        XCTAssertTrue(routing.routeToDetailWasCalled)
    }

}
