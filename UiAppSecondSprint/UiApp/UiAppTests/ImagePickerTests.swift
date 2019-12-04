//
//  ImagePickerTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 03.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest

class ImagePickerTests: XCTestCase {
    
    class MockImagePicker: ImagePickerDelegate {
        var recievedImage: UIImage?
        
        func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
            return
        }
        
        func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
            return
        }
        
        func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
            recievedImage = image
        }
        
        func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
            return
        }
    }
    
    func testThatImagePickerReturnsImageToDelegate() {
        // Arrange
        if let imageURL = Bundle(for: type(of: self)).url(forResource: "wylsa", withExtension: "png"),
            let imageData = try? Data(contentsOf: imageURL),
            let image = UIImage(data: imageData) {
            let imagePicker = ImagePicker()
            let imagePickerDelegate = MockImagePicker()
            imagePicker.delegate = imagePickerDelegate
            
            // Act
            imagePicker.delegate?.imagePickerDelegate(didSelect: image, delegatedForm: imagePicker)
            
            // Assert
            XCTAssertNotNil(imagePickerDelegate.recievedImage)
        } else {
            XCTFail()
        }
    }

}
