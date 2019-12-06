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
        if let image = UIImage(named: "someImage", in: Bundle(for: RootViewController.self), with: nil),
           let imageData = image.jpegData(compressionQuality: 0) {
            
            // Act
            let imageDataSizeInMB = imageData.getSizeInMB()
            
            // Assert
            XCTAssertEqual(imageDataSizeInMB, 10.2)
        } else {
            XCTFail()
        }
    }
    
}
