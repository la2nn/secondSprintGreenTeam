//
//  CollectionViewDataModel.swift
//  UiApp
//
//  Created by Николай Спиридонов on 12.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import Foundation

class CollectionViewDataModel {
    struct DataModel {
        var index: Int
        var columnName: String = "Имя колонны..."
        var textForEachLabel: Array<String> = []
    }
    
    static let shared = CollectionViewDataModel()

    var dataModel: Array<DataModel> = []
    
    private init() { }
}
