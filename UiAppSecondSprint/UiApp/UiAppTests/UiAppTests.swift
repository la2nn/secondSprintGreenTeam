//
//  UiAppTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 28.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class UiAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testThatNoColumnsAreCreated() {
        let dataModel = CollectionViewDataModel.shared
    
        let amountOfColumns = dataModel.getCountOfColumns()
        
        XCTAssertEqual(amountOfColumns, 0)
    }
    
    func testThatNewColumnHasFrame() {
        let newColumn = CreateNewColumnCell()
        
        let frame = newColumn.frame
        
        XCTAssertNotEqual(frame, CGRect.zero)
    }
    
    func testThatDataContainerAppendsCellWithTitle() {
        let cell = NotesDataModel.CellDataModel(text: "Test string", image: nil, imageURL: nil)
      
        NotesDataModel.shared.dataModel.append(cell)
        
        XCTAssertEqual(NotesDataModel.shared.dataModel.last!.text, "Test string")
    }
    
    func testTasksColumnInsertedRowTitle() {
        let tasksColumn = TasksColumnCell(frame: .zero)
        tasksColumn.cards = ["тест1"]
        tasksColumn.idList = "someID"
        tasksColumn.listName = "list"
        
        let cell = tasksColumn.tableView(tasksColumn.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! TasksTableViewCell
        
        XCTAssertEqual(cell.infoLabel.text!, "тест1")
    }
    
    func testTasksColumnInsertedRowCount() {
        let tasksColumn = TasksColumnCell(frame: .zero)
        tasksColumn.cards = ["тест1", "тест2", "тест3", "тест4", "тест5"]
        tasksColumn.idList = "someID"
        tasksColumn.listName = "list"
        
        let count = tasksColumn.tableView(tasksColumn.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(count, 5)
    }
    
    func testThatNotesViewControllerHasRightAmountOfNotes() {
        let notesVC = NotesViewController()
        NotesDataModel.shared.dataModel = [NotesDataModel.CellDataModel(text: "1"),
                                           NotesDataModel.CellDataModel(text: "2"),
                                           NotesDataModel.CellDataModel(text: "3")]
        
        notesVC.viewDidLoad()
        
        XCTAssertEqual(notesVC.tableView.numberOfRows(inSection: 0), 3)
    }
    
    func testThatSignInViewControllerHasSignInButton() {
        let signInVC = SignInViewController()
        
        signInVC.setButton()
       
        XCTAssertTrue(signInVC.registerButton.titleLabel?.text == "Нажмите на кнопку")
    }
    
    func testHowCellModelCanDecodeJsonObjects() {
        let data = try! JSONSerialization.data(withJSONObject: ["content" : "hello",
                                                                "imageURL" : "google.com"], options: [])
        
        let cell = try! JSONDecoder().decode(NotesDataModel.CellDataModel.self, from: data)
        
        XCTAssertEqual(cell.text, "hello")
    }
}

