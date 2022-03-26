//
//  Presenter.swift
//  NewsFeed
//
//  Created by Наида Мамаева on 17.03.2022.
//

import Foundation

protocol MainViewProtocol { // output
    
}

protocol TableViewInput{  // input
    func succesObtainNews(news: [Response])
    func failureObtainNews(error: String)
    
}

class Presenter {
   
    var view: TableViewInput?
    
    init(view: TableViewInput) {
        self.view = view
    }
    

    
    
}
