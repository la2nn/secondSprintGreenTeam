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
        // Arrange
        let cell = NotesDataModel.CellDataModel(text: "Test string", image: nil, imageURL: nil)
        
        // Act
        NotesDataModel.shared.dataModel.append(cell)

        // Assert
        XCTAssertEqual(NotesDataModel.shared.dataModel.last?.text, "Test string")
    }
    
    func testThatNotesDataModelCanAppendData() {
        // Arrange
        let cellsDataModel = NotesDataModel.shared
        
        // Act
        cellsDataModel.dataModel.append(NotesDataModel.CellDataModel(text: "Some text"))
        
        // Assert
        XCTAssertTrue(cellsDataModel.hasData())
    }
    
    func testThatNotesDataModelCanBeDecodedFromJson() {
        // Arrange
        var cellData: NotesDataModel.CellDataModel?
        
        // Act
        cellData = NotesDataModel.CellDataModel.initFromJson()
        
        // Assert
        XCTAssertNotNil(cellData)
    }
    
}
