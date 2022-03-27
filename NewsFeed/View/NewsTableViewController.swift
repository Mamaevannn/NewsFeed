//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Наида Мамаева on 16.03.2022.
//

import UIKit
import SafariServices

class NewsTableViewController: UITableViewController {
    
    @IBOutlet weak var newSegemnt: UISegmentedControl!
    
    var articlesData = [Article]()
    var presenter: Presenter?
    let service = Service()
   
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
        
        setupView()
    }
    
    
    private func setupView() {
      
        // set up search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // network
        
        
//        self.service.getSegmentedNews(topic: )
        self.service.getSegmentedNews(topic: "general", completion: { news in
            self.articlesData = news.articles ?? []
        })
        service.completionHandler { [weak self] (articles, status, message) in
            if status {
                guard let self = self else {return}
                guard let _articles = articles?.articles else {return}
                self.articlesData = _articles
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    @IBAction func didSelectCategory(_ sender: UISegmentedControl) {
        guard let categoryTitle = sender.titleForSegment(at: newSegemnt.selectedSegmentIndex) else { return }
        print("title \(categoryTitle)")
        self.service.getSegmentedNews(topic: categoryTitle, completion: { news in
            self.articlesData = news.articles ?? []
        })
//        self.tableView.reloadData()
 
        
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredNews.count
        }
        return articlesData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        var article: Article
        if isFiltering {
            article = filteredNews[indexPath.row]
        }
        else {
            article = articlesData[indexPath.row]
        }
        cell.configure(with: article)
        return cell
    }
}

extension NewsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, with: articlesData)
    }
    private func filterContentForSearchText( _ searchText: String, with news: [Article]) {
        filteredNews = articlesData.filter({ (news: Article) -> Bool in
            return news.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

extension NewsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let config = SFSafariViewController.Configuration.init()
        config.barCollapsingEnabled = true
        
        let selectedNews = articlesData[indexPath.row]
        guard let url = URL(string: selectedNews.url) else {return}
        let safariVC = SFSafariViewController(url: url, configuration: config)
        present(safariVC, animated: true, completion: nil)
        modalPresentationStyle = .fullScreen
        
    }
}
