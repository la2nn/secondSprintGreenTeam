//
//  TrelloNetworkingTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 03.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest

class TrelloNetworkingTests: XCTestCase {

    class MockTrelloNetworking: TrelloNetworking {
        override func get(_ callback: @escaping (Bool) -> Void) {
            callback(true)
        }
    }
    
    func testThatGetFuncCallsCallback() {
        // Arrange
        let trello = MockTrelloNetworking()
        
        // Act
        trello.get { (result) in
            
            // Assert
            XCTAssertTrue(result)
        }
    }

}
