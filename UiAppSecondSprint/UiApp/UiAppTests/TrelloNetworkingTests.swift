//
//  TrelloNetworkingTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 12.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class TasksColumnCellFetchDataTests: XCTestCase {
    
    class MockedTrelloFetchData: TrelloFetchDataProtocol {
        func getLists(_ callback: @escaping ([List]?) -> Void) {
            callback([List(id: "тест", name: "тест")])
        }
        
        func getCards(_ callback: @escaping ([Card]?) -> Void) {
            callback([Card(idList: "test", name: "test")])
        }
    }

    func testThatCellCanFetchCards() {
        // Arrange
        let taskCell = TasksColumnCell()
        taskCell.fetchDataSource = MockedTrelloFetchData()

        // Act
        taskCell.fetchCards()
        
        // Asert
        if let fetchedCard = taskCell.fetchedCards?.first {
            XCTAssertEqual(fetchedCard.name, "test")
        } else {
            XCTFail()
        }
    }
    
    func testThatCellCanFetchLists() {
        // Arrange
        let taskCell = TasksColumnCell()
        taskCell.fetchDataSource = MockedTrelloFetchData()

        // Act
        taskCell.fetchLists()
        
        // Asert
        if let fetchedList = taskCell.fetchedLists?.first {
            XCTAssertEqual(fetchedList.name, "тест")
        } else {
            XCTFail()
        }
    }

}
