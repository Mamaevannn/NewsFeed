//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Наида Мамаева on 16.03.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var articles = Array<Article>()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return self.articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }

        let articles = articles[indexPath.row]
        cell.configure(with: articles)
        return cell
    }



}
    
