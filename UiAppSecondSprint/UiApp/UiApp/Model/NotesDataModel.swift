//
//  NotesModel.swift
//  UiApp
//
//  Created by Николай Спиридонов on 13.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import Foundation

class NotesDataModel {
    
    static let shared = NotesDataModel()
    
    var dataModel: Array<String> = []
    
    private init() { }
}
