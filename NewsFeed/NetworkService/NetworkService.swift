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
    private let apiKey = "6095bd68e8ed4b269ac01f27739f2d94"
    typealias newsCallBack = ( _ news: Response?, _ status : Bool, _ message: String) -> Void
    var callBack:  newsCallBack?

    
    
    func getData(topic: String = "general") {
        let endUrl = firstPartUrl + "\(topic)&apiKey=\(apiKey)"
        AF.request(endUrl).response { (resonseData) in
            guard let data = resonseData.data else {
                self.callBack?( nil, false, "")
                return}
            do {
                let news = try JSONDecoder().decode(Response.self, from: data)
//                print("got data \(news)")
                self.callBack?(news, true, "")
                let view = NewsTableViewController()
                view.tableView.reloadData()
                print("link for this category is \(endUrl)")
            } catch {
                print(error)
                self.callBack?( nil, false, error.localizedDescription)
            }
        }
    }
    
   
    
    func completionHandler(callBack: @escaping newsCallBack) {
        self.callBack = callBack
    }
}
