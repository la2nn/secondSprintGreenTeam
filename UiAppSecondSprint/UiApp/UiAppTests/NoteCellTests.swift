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
        if let image = UIImage(named: "someImage", in: Bundle(for: RootViewController.self), with: nil) {
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
    
    class MockNotesViewController: NoteCellDelegate {
        var cellIndex: Int?
        
        func addPhotoButtonPressed(cellIndex: Int?) {
            self.cellIndex = cellIndex
        }
    }
    
    func testThatNoteCellDelegateWorks() {
        // Arrange
        let notesVC = MockNotesViewController()
        let noteCell = NoteCell()
        noteCell.delegate = notesVC
        
        // Act
        noteCell.delegate?.addPhotoButtonPressed(cellIndex: 10)
        
        // Assert
        XCTAssertEqual(notesVC.cellIndex, 10)
    }
    
}
