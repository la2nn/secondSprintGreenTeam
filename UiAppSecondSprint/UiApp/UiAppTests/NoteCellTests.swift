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
        if let imageURL = Bundle(for: type(of: self)).url(forResource: "wylsa", withExtension: "png"),
            let imageData = try? Data(contentsOf: imageURL),
            let image = UIImage(data: imageData) {
            let cell = NoteCell(style: .default, reuseIdentifier: "any")
            guard let photoButton = cell.photoButton else { XCTFail() ; return }
            
            // Act (didSet method)
            cell.downloadedImage = image
            
            // Assert
            XCTAssertTrue(photoButton.isHidden)
        } else {
            XCTFail()
        }
        
    }
}
