//
//  ArticleDetailViewControllerTest.swift
//  NewsAppTests
//
//  Created by Resham gurung on 15/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import XCTest
@testable import NewsApp

class ArticleDetailViewControllerTest: XCTestCase {

    var window: UIWindow?
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow()
    }

    override func tearDown() {
        
        window = nil
        
        super.tearDown()
    }
    
    func test_init_shouldSetRouter() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleDetailVC = storyboard.instantiateViewController(identifier: "ArticleDetailViewController", creator: { coder in
            return ArticleDetailViewController(coder: coder)
        })
        
        // THEN
        XCTAssertNotNil(articleDetailVC.router)
    }
    
    func test_init_shouldSetInteractor() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleVC = storyboard.instantiateViewController(identifier: "ArticleDetailViewController", creator: { coder in
            return ArticleDetailViewController(coder: coder)
        })
        
        // THEN
        XCTAssertNotNil(articleVC.interactor)
    }
    
    func test_init_shouldSetPresenter() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleDetailVC = storyboard.instantiateViewController(identifier: "ArticleDetailViewController", creator: { coder in
            return ArticleDetailViewController(coder: coder)
        })
        
        // THEN
        if let interactor = articleDetailVC.interactor as? ArticleDetailInteractor, let presenter = interactor.presenter as? ArticleDetailPresenter {
            
            XCTAssertNotNil(presenter.viewController)
        } else {
            
            XCTFail()
        }
    }
    
    func test_init_shouldSetRouterViewController() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleDetailVC = storyboard.instantiateViewController(identifier: "ArticleDetailViewController", creator: { coder in
            return ArticleDetailViewController(coder: coder)
        })
        
        // THEN
        XCTAssertEqual(articleDetailVC.router?.viewController, articleDetailVC)
    }
    
    func test_viewDidAppearShouldFetchArticles() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let interactor = ArticleDetailVCBussinessLogic()
        
        let articleDetailVC = storyboard.instantiateViewController(identifier: "ArticleDetailViewController", creator: { coder in
            return ArticleDetailViewController(coder: coder)
        })
        
        articleDetailVC.interactor = interactor
        
        guard let w = window else {
            
            XCTFail("Window not set")
            
            return
        }
        
        loadView(window: w, viewController: articleDetailVC)
        
        // THEN
        XCTAssertTrue(interactor.getArticlesWasCalled)
    }
    
    func test_IBOutlets() {
        
        // GIVEN
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleDetailVC = storyboard.instantiateViewController(identifier: "ArticleDetailViewController", creator: { coder in
            return ArticleDetailViewController(coder: coder)
        })
        
        guard let w = window else {
            
            XCTFail("Window not set")
            
            return
        }
        
        loadView(window: w, viewController: articleDetailVC)
        
        let viewModel = ArticleDetailModels.ViewModel(displayedArticle: ArticleDetailModels.ViewModel.DisplayedModel(source: ArticleDetailModels.ViewModel.DisplayedModel.DisplayedSource(id: "", name: ""), author: "", title: "XCTEST", description: "", url: "", urlToImage: "", publishedAt: "", content: "XCTEST_CONTENT"))
        // WHEN
        articleDetailVC.displayArticle(viewModel: viewModel)
        
        // THEN
        XCTAssertEqual(articleDetailVC.contentLabel.text, "XCTEST_CONTENT")
        XCTAssertEqual(articleDetailVC.titleLabel.text, "XCTEST")
    }
}
