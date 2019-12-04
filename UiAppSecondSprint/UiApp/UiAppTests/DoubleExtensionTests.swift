//
//  DoubleExtensionTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 02.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class DoubleExtensionTests: XCTestCase {
    
    func testThatDataExtendedMethodReturnsRightDataSizeInMegabytes() {
        // Arrange
        if let imageURL = Bundle(for: type(of: self)).url(forResource: "test", withExtension: "jpg"),
           let imageData = try? Data(contentsOf: imageURL) {
            
            // Act
            let imageDataSizeInMB = imageData.getSizeInMB()
            
            // Assert
            XCTAssertEqual(imageDataSizeInMB, 10.2)
        } else {
            XCTFail()
        }
    }
    
}
