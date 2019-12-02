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
        let dataModel = CollectionViewDataModel.shared
    
        let amountOfColumns = dataModel.getCountOfColumns()
        
        XCTAssertEqual(amountOfColumns, 0)
    }

}
