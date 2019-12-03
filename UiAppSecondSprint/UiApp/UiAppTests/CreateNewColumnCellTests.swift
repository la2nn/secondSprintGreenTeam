//
//  UiAppTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 28.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class CreateNewColumnCellTests: XCTestCase {

    func testThatNewColoumnCellDelegateWorks() {
        // Arrange
        let cell = CreateNewColumnCell()
        let viewController = MainViewController()
        cell.delegate = viewController
        guard let cellBackgroundColor = cell.backgroundColor else { return }
            
        // Act
        cell.delegate?.backgroundColorDidChange?(newColor: cellBackgroundColor)
        
        // Assert
        XCTAssertEqual(viewController.receivedColor, cellBackgroundColor)
    }
    
}

