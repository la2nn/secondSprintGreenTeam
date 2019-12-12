//
//  TrelloAPI.swift
//  UiApp
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import Foundation

class TrelloNetworking: TrelloFetchDataProtocol, TrelloUploadDataProtocol {
    
    private enum UrlParts: String {
        case idBoard = "2XJ1X5mg"
        case apiToken = "375c9d91cf52dd50f5feb1c2b7ca76fdd2ac9f621ddaf08e3686ee1d5e7a650c"
        case apiKey = "28e8753e7b1cb1c96af05f7e48fd6748"
        
        static var trelloCardLink: String {
            return """
                        https://api.trello.com/1/boards/\(idBoard.rawValue)/
                                cards?fields=idList,name&key=\(apiKey.rawValue)
                                &token=\(apiToken.rawValue)
                   """
        }
        
        static var trelloListLink: String {
            return """
                       https://api.trello.com/1/boards/\(idBoard.rawValue)/
                       lists?fields=name&key=\(apiKey.rawValue)
                       &token=\(apiToken.rawValue)
                   """
        }
    }

    func getLists(_ callback: @escaping ([List]?) -> Void) {
        guard let postsUrl = URL(string: UrlParts.trelloListLink) else {
            callback(nil)
            return
        }
        
        let request = URLRequest(url: postsUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let posts = try? JSONDecoder().decode([List].self, from: data) {
                callback(posts)
            } else {
                callback(nil)
            }
        }.resume()
    }
    
    func getCards(_ callback: @escaping ([Card]?) -> Void) {
        guard let postsUrl = URL(string: UrlParts.trelloCardLink) else {
            callback(nil)
            return
        }
        
        let request = URLRequest(url: postsUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let cards = try? JSONDecoder().decode([Card].self, from: data) {
                callback(cards)
            } else {
                callback(nil)
            }
        }.resume()
    }
    
    func post(_ card: ListWithCards) {
        guard !card.idList.isEmpty,
            let uploadData = try? JSONEncoder().encode(card),
            let urlString = """
                https://api.trello.com/1/cards?name=\(card.cards[0])
                &idList=\(card.idList)
                &keepFromSource=all
                &key=\(UrlParts.apiKey.rawValue)
                &token=\(UrlParts.apiToken.rawValue)
                """.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: urlString)
            else {
                return
            }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.uploadTask(with: request, from: uploadData).resume()
    }
    
}

protocol TrelloFetchDataProtocol {
    func getLists(_ callback: @escaping ([List]?) -> Void)
    func getCards(_ callback: @escaping ([Card]?) -> Void)
}

protocol TrelloUploadDataProtocol {
    func post(_ card: ListWithCards)
}
