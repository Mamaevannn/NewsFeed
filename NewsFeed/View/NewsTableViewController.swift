//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Наида Мамаева on 16.03.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var articles = Array<Article>()
    var presenter: Presenter?
 
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredNews = Array<Article>()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false  }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        
        // network
        let service = Service(url: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6095bd68e8ed4b269ac01f27739f2d94")
        service.getData()
        service.completionHandler { [weak self] (articles, status, message) in
            if status {
                guard let self = self else {return}
                guard let _articles = articles?.articles else {return}
                self.articles = _articles
                self.tableView.reloadData()
        }
            

    }
            }
    
    
   
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
           return filteredNews.count
        }
        return self.articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }

        var article: Article
        if isFiltering {
            article = filteredNews[indexPath.row]
        } else {
         article = articles[indexPath.row]
        }
        cell.configure(with: article)
        return cell
    }



}

extension NewsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, with: articles)
    }
    private func filterContentForSearchText( _ searchText: String, with news: [Article]) {
        filteredNews = articles.filter({ (news: Article) -> Bool in
            return news.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
    
