//
//  NotesDataModelTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 02.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class NotesDataModelTests: XCTestCase {
    
    func testThatNotesDataModelCanAppendCellWithCorrectTitle() {
        let cell = NotesDataModel.CellDataModel(text: "Test string", image: nil, imageURL: nil)
        
        NotesDataModel.shared.dataModel.append(cell)
        
        XCTAssertEqual(NotesDataModel.shared.dataModel.last!.text, "Test string")
    }
    
    func testThatNotesDataModelCanAppendData() {
        let cellsDataModel = NotesDataModel.shared
        
        cellsDataModel.dataModel.append(NotesDataModel.CellDataModel(text: "Some text"))
        
        XCTAssertTrue(cellsDataModel.hasData())
    }
    
    func testThatNotesDataModelCanBeDecodedFromJson() {
        var cellData: NotesDataModel.CellDataModel?
        
        cellData = NotesDataModel.CellDataModel.initFromJson()
        
        XCTAssertNotNil(cellData)
    }
    
}
