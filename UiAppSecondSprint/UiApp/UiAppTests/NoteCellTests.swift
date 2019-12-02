//
//  NoteCellTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 02.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class NoteCellTests: XCTestCase {

    func testThatDidSetMethodOfDownloadedImageHidesPhotoButton() {
        let cell = NoteCell(style: .default, reuseIdentifier: "any")
        
        cell.downloadedImage = #imageLiteral(resourceName: "swiftLogo")
        
        XCTAssertTrue(cell.photoButton!.isHidden)
    }
    
}
