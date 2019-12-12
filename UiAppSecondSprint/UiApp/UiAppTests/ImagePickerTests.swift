//
//  ImagePickerTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 03.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class ImagePickerTests: XCTestCase {
    
    class SpyImagePicker: ImagePickerDelegate {
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
        if let image = UIImage(named: "swiftLogo", in: Bundle(for: RootViewController.self), with: nil) {
            let imagePicker = ImagePicker()
            let imagePickerDelegate = SpyImagePicker()
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
