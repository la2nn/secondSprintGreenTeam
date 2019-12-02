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
        var tasksColumn: TasksColumnCell?
        
        tasksColumn = TasksColumnCell.initWith(cards: ["first", "seconds"])
        
        XCTAssertNotNil(tasksColumn)
    }

   func testThatTableViewCellHasRightTextLabel() {
        let tasksColumn = TasksColumnCell.initWith(cards: ["тест1"])!
        
        let cell = tasksColumn.tableView(tasksColumn.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TasksTableViewCell
        
        XCTAssertEqual(cell.infoLabel.text!, "тест1")
    }
    
    func testThatTableViewHasRightAmountOfCells() {
        let tasksColumn = TasksColumnCell.initWith(cards: ["тест1", "тест2", "тест3", "тест4", "тест5"])!
        
        let count = tasksColumn.tableView(tasksColumn.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(count, 5)
    }

}
