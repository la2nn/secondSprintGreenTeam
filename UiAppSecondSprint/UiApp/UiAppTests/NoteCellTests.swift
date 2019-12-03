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
        // Arrange
        guard let image = UIImage(named: "swifLogo") else { return }
        let cell = NoteCell(style: .default, reuseIdentifier: "any")
        guard let photoButton = cell.photoButton else { return}
        
        // Act (didSet method)
        cell.downloadedImage = image
        
        // Assert
        XCTAssertTrue(photoButton.isHidden)
    }
    
}
