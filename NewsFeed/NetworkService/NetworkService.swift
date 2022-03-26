//
//  NetworkService.swift
//  NewsFeed
//
//  Created by Наида Мамаева on 16.03.2022.
//

import Foundation
import Alamofire

class Service {
    private let firstPartUrl = "https://newsapi.org/v2/top-headlines?country=ru&category="
    private let apiKey = "33895be136484de0a4f6007cee094964"
    typealias newsCallBack = ( _ news: Response?, _ status : Bool, _ message: String) -> Void
    var callBack:  newsCallBack?
    private var articlesData = [Article]()
    
    
    func getData <T> (topic: String, completion : @escaping ((Result<T,NError>)-> Void)) {
        let endUrl = firstPartUrl + "\(topic)&apiKey=\(apiKey)"
        AF.request(endUrl).response { (resonseData) in
            guard let data = resonseData.data else {
                self.callBack?( nil, false, "")
                return}
            do {
                let news = try JSONDecoder().decode(Response.self, from: data)
                print("got data \(news)")
                self.callBack?(news, true, "")
             
                print("link for this category is \(endUrl)")
            } catch {
                print(error)
                self.callBack?( nil, false, error.localizedDescription)
            }
        }
    }
    
    func getSegmentedNews(topic: String = "general") {
        getData(topic: topic) { (result : Result<Response, NError>) in
            switch result {
            case .success(let news):
                self.updateUI(with: news.articles ?? [])
            case .failure(let failure):
                print(failure.rawValue)
            }
        }
    }
    
    func updateUI(with news : [Article]) {
        
        DispatchQueue.main.async {
            self.articlesData.append(contentsOf: news)
            let view = NewsTableViewController()
            view.tableView.reloadData()
        }
        if news.isEmpty {
            print("no news")
        }
    }
    
    func completionHandler(callBack: @escaping newsCallBack) {
        self.callBack = callBack
    }
}
