//
//  CollectionViewDataModel.swift
//  UiApp
//
//  Created by Николай Спиридонов on 12.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import Foundation

struct Card: Decodable {
    let idList: String
    let name: String
}

struct List: Decodable {
    let id: String
    let name: String
}


struct ListWithCards {
    let list: String
    var cards: [String]
}

class CollectionViewDataModel {
    
    static let shared = CollectionViewDataModel()

    var dataModel: Array<ListWithCards> = []
    
    private init() { }
}
