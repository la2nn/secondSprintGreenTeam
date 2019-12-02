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
    
    func testThatNewColumnCellHasFrame() {
        let newColumn = CreateNewColumnCell()
        
        let frame = newColumn.frame
        
        XCTAssertNotEqual(frame, CGRect.zero)
    }
    
    func testThatNewColoumnCellDelegateWorks() {
        let cell = CreateNewColumnCell()
        let viewController = MainViewController()
        cell.delegate = viewController
        
        cell.delegate?.backgroundColorDidChange?(newColor: cell.backgroundColor!)
        
        XCTAssertEqual(viewController.receivedColor!, cell.backgroundColor!)
    }
    
}

