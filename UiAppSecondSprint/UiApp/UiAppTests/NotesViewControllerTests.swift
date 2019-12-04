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
    
    class MockNotesViewController: NotesViewController {
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
    
    func testThatTableViewHasRightAmountOfNotes() {
        // Arrange
        let notesVC = MockNotesViewController()
        
        // Act
        notesVC.viewDidLoad()
        
        // Assert
        XCTAssertEqual(notesVC.tableView.numberOfRows(inSection: 0), 4)
    }
    
}
