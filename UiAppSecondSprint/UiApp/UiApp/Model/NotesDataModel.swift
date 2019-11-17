//
//  NotesModel.swift
//  UiApp
//
//  Created by Николай Спиридонов on 13.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class NotesDataModel {
    
    class CellDataModel: Codable {
        var text: String
        var imageURL: String?
        var image: UIImage? = nil
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(text, forKey: .text)
            try container.encode(imageURL ?? "nil", forKey: .imageURL)
        }
        
        enum CodingKeys: String, CodingKey {
            case text = "content"
            case imageURL = "imageURL"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.text = try container.decode(String.self, forKey: .text)
            self.imageURL = try container.decode(String?.self, forKey: .imageURL)
        }
        
        init(text: String, image: UIImage? = nil, imageURL: String? = nil) {
            self.text = text
            self.image = image
            self.imageURL = imageURL
        }
    }
    
    static let shared = NotesDataModel()
    
    static func uploadNotesToFirebase(_ completionHandler: @escaping(Bool) -> Void) {
        let config = URLSessionConfiguration.default
        var request = URLRequest(url: URL(string: "https://sprint-e1df8.firebaseio.com/notes.json?auth=7ptTMrMXzwLqEHn3PnhDwDpipWCXJnhwnVwGeacW")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 40)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        do {
            request.httpBody = try JSONEncoder().encode(NotesDataModel.shared.dataModel)
        } catch {
            print(error.localizedDescription)
        }
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            if error == nil {
                completionHandler(false)
            } else {
                completionHandler(true)
            }
        }.resume()
    }
    
    var dataModel: Array<CellDataModel> = []
    
    private init() { }
}
