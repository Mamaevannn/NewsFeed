//
//  NetworkService.swift
//  NewsFeed
//
//  Created by Наида Мамаева on 16.03.2022.
//

import Foundation
import Alamofire

class Service {
    
    var url = ""
    typealias newsCallBack = ( _ news: Response?, _ status : Bool, _ message: String) -> Void
    var callBack:  newsCallBack?

    
    init(url: String) {
        self.url = url
    }
    
    func getData() {
        AF.request(self.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (resonseData) in
            guard let data = resonseData.data else {
                self.callBack?( nil, false, "")
                return}
            do {
                let news = try JSONDecoder().decode(Response.self, from: data)
//                print("ok \(news)")
                self.callBack?(news, true, "")
                
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
