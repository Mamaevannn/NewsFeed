//
//  NetworkError.swift
//  NewsFeed
//
//  Created by Наида Мамаева on 27.03.2022.
//

import Foundation

enum NError : String, Error {
    
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from server was invalid. Please Try Again"

}
