//
//  NotesModel.swift
//  UiApp
//
//  Created by Николай Спиридонов on 13.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class NotesDataModel {
    
    class CellDataModel {
        var text: String
        var image: UIImage?
        
        init(text: String) {
            self.text = text
        }
    }
    
    static let shared = NotesDataModel()
    
    var dataModel: Array<CellDataModel> = []
    
    private init() { }
}

