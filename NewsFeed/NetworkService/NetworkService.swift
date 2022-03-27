//
//  NetworkService.swift
//  NewsFeed
//
//  Created by Наида Мамаева on 16.03.2022.
//

import Foundation
import Alamofire

class Service {
    private let firstPartUrl = "https://newsapi.org/v2/top-headlines?language=ru&pageSize=100&category="
    private let apiKey = "6095bd68e8ed4b269ac01f27739f2d94"
    typealias newsCallBack = ( _ news: Response?, _ status : Bool, _ message: String) -> Void
    var callBack:  newsCallBack?
    private var articlesData = [Article]()
    
    
    func getNews <T> (topic: String, completion : @escaping ((Result<T,NError>)-> Void)) {
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
    
    func getSegmentedNews(topic: String = "general", completion: @escaping ((Response) -> Void)) {
        getNews(topic: topic) { (result : Result<Response, NError>) in
            switch result {
            case .success(let news):
                completion(news)
//                self.updateUI(with: news.articles ?? [])
            case .failure(let failure):
                print(failure.rawValue)
            }
        }
    }
    
//    func updateUI(with news : [Article]) {
//
//        DispatchQueue.main.async {
//            self.articlesData.append(contentsOf: news)
//            let view = NewsTableViewController()
//            view.tableView.reloadData()
//        }
//        if news.isEmpty {
//            print("no news")
//        }
//    }
    
    func completionHandler(callBack: @escaping newsCallBack) {
        self.callBack = callBack
    }
}
