//
//  CollectionViewDataModelTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 02.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class CollectionViewDataModelTests: XCTestCase {

    func testThatCollectionViewDataModelHasNoData() {
        // Arrange
        let dataModel = CollectionViewDataModel.shared
    
        // Act
        let amountOfColumns = dataModel.getCountOfColumns()
        
        // Assert
        XCTAssertEqual(amountOfColumns, 0)
    }

}
