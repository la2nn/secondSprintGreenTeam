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
        guard let image = UIImage(named: "someImage"), let imageData = image.jpegData(compressionQuality: 0) else { return }
        
        // Act
        let imageDataSizeInMB = imageData.getSizeInMB()
        
        // Assert
        XCTAssertEqual(imageDataSizeInMB, 10.2)
    }
    
}
