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
        let imageData = #imageLiteral(resourceName: "someImage").jpegData(compressionQuality: 0)!
        
        let imageDataSizeInMB = imageData.getSizeInMB()
        
        XCTAssertEqual(imageDataSizeInMB, 10.2)
    }
    
}
