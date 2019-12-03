//
//  TasksColumnCellTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 02.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class TasksColumnCellTests: XCTestCase {
    
    func testThatTasksColumnCellCanBeInitializedWithCards() {
        // Arrange
        var tasksColumn: TasksColumnCell?
        
        // Act
        tasksColumn = TasksColumnCell.initWith(cards: ["first", "seconds"])
        
        // Assert
        XCTAssertNotNil(tasksColumn)
    }

   func testThatTableViewCellHasRightTextLabel() {
        // Arrange
        let tasksColumn = TasksColumnCell.initWith(cards: ["тест1"])!
        
        // Act
        let cell = tasksColumn.tableView(tasksColumn.tableView,
                                         cellForRowAt: IndexPath(row: 0, section: 0)) as? TasksTableViewCell
        
        // Assert
        XCTAssertEqual(cell?.infoLabel.text, "тест1")
    }
    
    func testThatTableViewHasRightAmountOfCells() {
        // Arrange
        let tasksColumn = TasksColumnCell.initWith(cards: ["тест1", "тест2", "тест3", "тест4", "тест5"])!
        
        // Act
        let count = tasksColumn.tableView(tasksColumn.tableView, numberOfRowsInSection: 0)
        
        // Assert
        XCTAssertEqual(count, 5)
    }

}
