//
//  ArticleTableViewController.swift
//  NewsApp
//
//  Created by Resham gurung on 10/01/2020.
//  Copyright © 2020 HAUDAE.com. All rights reserved.
//

import UIKit


    //MARK: - Article DisplayLogic

protocol ArticleTableViewControllerDisplayLogic: class {
    
    func displayFetchedArticles(viewModel: ArticleModels.ViewModel)
    
    func displayError(viewModel: ErrorViewModel)
    
}


    //MARK: - ArticleTableViewController

class ArticleTableViewController: UITableViewController, ErrorPresenting  {

    var interactor: ArticleBussinessLogic?
    
    var router: (NSObjectProtocol & ArticleRoutingProtocol & ArticleDataPassing)?
    
    var displayedArticles: [ArticleModels.ViewModel.DisplayArticle] = []
    
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
      
        fetchArticles()
    }

    func setup() {
        
        let viewController = self
        
        let presenter = ArticlePresenter(viewController: viewController)
        
        let interactor = ArticleInteractor(presenter: presenter)
        
        let router = ArticleRouter(viewController: viewController)
        
        viewController.interactor = interactor
        
        viewController.router = router
        
        router.dataStore = interactor
    }
    
    func fetchArticles() {
        
        let request = ArticleModels.Request()
        
        interactor?.getArticles(request: request)
    }

}

    // MARK: - UITableViewDataSource

extension ArticleTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return displayedArticles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)

        cell.textLabel?.text = displayedArticles[indexPath.row].title
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ArticleTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        router?.routeToDetail(indexPath: indexPath, animated: true)
    }
}

// MARK: - DisplayLogic

extension ArticleTableViewController: ArticleTableViewControllerDisplayLogic {
    
    func displayFetchedArticles(viewModel: ArticleModels.ViewModel) {
        
        displayedArticles = viewModel.articles
        
        tableView.reloadData()
    }
    
    func displayError(viewModel: ErrorViewModel) {
        
        presentError(viewModel: viewModel)
    }
    
}
