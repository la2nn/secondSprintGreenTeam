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
        let signInVC = SignInViewController()
        
        signInVC.setButton()
       
        XCTAssertTrue(signInVC.registerButton.titleLabel?.text == "Нажмите на кнопку")
    }
    
    func testThatSignInViewControllerHasRightTitle() {
        let signInVC = SignInViewController()
        
        signInVC.viewDidLoad()
        
        XCTAssertEqual(signInVC.title, "Регистрация")
    }

}
