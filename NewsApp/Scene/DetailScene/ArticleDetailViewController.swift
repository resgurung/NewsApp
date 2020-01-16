//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by Resham gurung on 11/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import UIKit


protocol ArticleDetailViewControllerDisplayLogic: class {
    
    func displayArticle(viewModel: ArticleDetailModels.ViewModel)
    
    func displayError(errorViewModel: ErrorViewModel)
}


class ArticleDetailViewController: UIViewController, ErrorPresenting {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    var interactor: ArticleDetailInteractorBussinessLogic?
    
    var router: (NSObjectProtocol & ArticleDetailRouting & ArticleDetailDataPassing)?
        
    // MARK: - Constructor
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchArticle()
    }
    
    
    func setup() {
        
        let viewController = self
        
        let router = ArticleDetailRouter(viewController: viewController)
        
        let presenter = ArticleDetailPresenter(viewController: viewController)
        
        let interactor = ArticleDetailInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        
        viewController.router = router
        
        router.dataStore = interactor
        
    }
    
    func fetchArticle() {
        
        let request = ArticleDetailModels.Request()
        
        interactor?.getArticle(request: request)
    }
}


// MARK: - DisplayLogic

extension ArticleDetailViewController: ArticleDetailViewControllerDisplayLogic {
    
    func displayArticle(viewModel: ArticleDetailModels.ViewModel) {
        
        titleLabel.text = viewModel.displayedArticle.title
        
        contentLabel.text = viewModel.displayedArticle.content
    }
    
    func displayError(errorViewModel: ErrorViewModel) {
        
        presentError(viewModel: errorViewModel)
    }
    
    
}
