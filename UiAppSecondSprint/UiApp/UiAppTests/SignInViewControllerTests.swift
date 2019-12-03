//
//  SignInViewControllerTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 02.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class SignInViewControllerTests: XCTestCase {

    func testThatSignInViewControllerHasSignInButton() {
        // Arrange
        let signInVC = SignInViewController()
        
        // Act
        signInVC.setButton()
       
        // Assert
        XCTAssertTrue(signInVC.registerButton.titleLabel?.text == "Нажмите на кнопку")
    }
    
    func testThatSignInViewControllerHasRightTitle() {
        // Arrange
        let signInVC = SignInViewController()
        
        // Act
        signInVC.viewDidLoad()
        
        // Assert
        XCTAssertEqual(signInVC.title, "Регистрация")
    }

}
