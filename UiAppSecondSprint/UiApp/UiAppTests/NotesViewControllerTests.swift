//
//  NotesViewControllerTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 02.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class NotesViewControllerTests: XCTestCase {

    func testThatControllerHasRightAmountOfNotes() {
        // Arrange
        let notesVC = NotesViewController()
        NotesDataModel.shared.dataModel = [NotesDataModel.CellDataModel(text: "1"),
                                           NotesDataModel.CellDataModel(text: "2"),
                                           NotesDataModel.CellDataModel(text: "3")]
        // Act
        notesVC.viewDidLoad()
        
        // Assert
        XCTAssertEqual(notesVC.tableView.numberOfRows(inSection: 0), 3)
    }

    override class func setUp() {
        NotesDataModel.shared.dataModel.removeAll()
        super.setUp()
    }
    
    struct MockNotesData {
        var notes = ["one", "two", "three", "four"]
        init() { }
    }
    
    func testThatTableViewHasRightAmountOfNotesWithControllerInitialize() {
        // Arrange
        let notesVC = NotesViewController(notes: MockNotesData().notes)
        
        // Act
        notesVC.viewDidLoad()
        
        // Assert
        XCTAssertEqual(notesVC.tableView.numberOfRows(inSection: 0), 4)
    }
    
    
}
