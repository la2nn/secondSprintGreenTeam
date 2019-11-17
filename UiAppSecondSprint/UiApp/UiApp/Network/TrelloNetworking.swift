//
//  TrelloAPI.swift
//  UiApp
//
//  Created by Николай Спиридонов on 16.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import Foundation

class TrelloNetworking {
    
    private var arrayListWithCards: [ListWithCards] = []

    private var cortege = (false, false) {
        didSet {
            if self.cortege == (true, true) {
                for i in self.lists {
                    var listCard = ListWithCards(idList: i.id, list: i.name, cards: [])
                    for j in self.cards {
                        if j.idList == i.id {
                            listCard.cards.append(j.name)
                        }
                    }
                    arrayListWithCards.append(listCard)
                    
                }
            }
            CollectionViewDataModel.shared.dataModel = arrayListWithCards
            print(arrayListWithCards)
        }
    }
    private let idBoard = "2XJ1X5mg"
    private let apiToken: String = "375c9d91cf52dd50f5feb1c2b7ca76fdd2ac9f621ddaf08e3686ee1d5e7a650c"
    private let apiKey: String = "28e8753e7b1cb1c96af05f7e48fd6748"
     var trelloCardLink: String {
        return "https://api.trello.com/1/boards/\(idBoard)/cards?fields=idList,name&key=\(apiKey)&token=\(apiToken)"
    }

    private var trelloListLink: String {
        return "https://api.trello.com/1/boards/\(idBoard)/lists?fields=name&key=\(apiKey)&token=\(apiToken)"
    }
    
    

    private var cards: [Card] = []
    private var lists: [List] = []

    public static let shared = TrelloNetworking()

    func get(_ callback: @escaping (Bool) -> Void) {
        // MARK: GET ЗАПРОС
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url2 = URL(string: trelloListLink)!
              let urlRequest2 = URLRequest(url: url2, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
              
              let task2 = session.dataTask(with: urlRequest2, completionHandler: {(data, response, error)
                  in
                  do {
                      let posts = try JSONDecoder().decode([List].self, from: data!)
                      self.lists = Array(posts)
                      self.cortege.0 = true
                      callback(true)
                  } catch {
                      callback(false)
                  }
              })
        
        let url1 = URL(string: trelloCardLink)!
        let urlRequest1 = URLRequest(url: url1, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
        
        let task1 = session.dataTask(with: urlRequest1, completionHandler: {(data, response, error)
            in
            do {
                let posts = try JSONDecoder().decode([Card].self, from: data!)
                self.cards = Array(posts)
                self.cortege.1 = true
                task2.resume()

            } catch {
                print(error)
            }
        })
        task1.resume()
        
    }
    // MARK: POST ЗАПРОС
    func post(_ card: ListWithCards) {
            
            guard card.idList != "" else { return }
        
            guard let uploadData = try? JSONEncoder().encode(card) else { return }
            
        let urlString = "https://api.trello.com/1/cards?name=\(card.cards[0])&idList=\(card.idList)&keepFromSource=all&key=\(apiKey)&token=\(apiToken)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            let myUrl = URL(string: urlString)!
            print(myUrl.absoluteString)
            
            var request = URLRequest(url: myUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
                if let error = error {
                    print ("error: \(error)")
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                        print ("server error")
                        return
                }
                if let mimeType = response.mimeType,
                    mimeType == "application/json",
                    let data = data,
                    let dataString = String(data: data, encoding: .utf8) {
                    print ("got data: \(dataString)")
                }
            }
            task.resume()
            return
        }
    
}
