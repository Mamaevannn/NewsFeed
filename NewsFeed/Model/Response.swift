//
//  Model.swift
//  NewsApp
//
//  Created by Наида Мамаева on 16.03.2022.
//

import Foundation

struct Response: Decodable {
    var articles: [Article]?
}

struct Source: Decodable {
    var name: String
    var id: String?

}
struct Article: Decodable {
    let source: Source
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

