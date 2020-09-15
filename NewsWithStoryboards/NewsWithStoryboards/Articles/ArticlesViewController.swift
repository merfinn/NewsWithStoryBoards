//
//  ArticlesViewController.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleTableView: UITableView!
    
    lazy var viewModel: ArticleListViewModel = { return ArticleListViewModel() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()   // Init the static view
        configureViewModel()  // init view model
    }
    
    func configureView() {
        navigationItem.title = "Articles"
        view.accessibilityIdentifier = "article_VC_AI"
        articleTableView.accessibilityIdentifier = "article_TV_AI"
    }
    
    private func configureViewModel() {
        
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false                
                isLoading ? self?.startAnimatingAndHideList() : self?.stopAnimatingAndShowList()
            }
        }
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.articleTableView?.reloadData()
            }
        }
        viewModel.initFetch()
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func startAnimatingAndHideList() {
        self.activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.2, animations: {
            self.articleTableView?.alpha = 0.0
        })
    }
    
    private func stopAnimatingAndShowList() {
        self.activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2, animations: {
            self.articleTableView?.alpha = 1.0
        })
    }
}


// MARK: - Tableview Delegate Extensions
extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCellIdentifier", for: indexPath) as? ArticleListCell else {
            fatalError("Cell does not exist in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.articleListCellViewModel = cellVM
        cell.accessibilityIdentifier = "articleCell_\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
}

extension ArticlesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.userPressed(at: indexPath)
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webviewId") as? DetailViewController {
            viewController.url = viewModel.selectedArticle?.url
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}
