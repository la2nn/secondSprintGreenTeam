//
//  SelfSizedUILabelTests.swift
//  UiAppTests
//
//  Created by Николай Спиридонов on 02.12.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import XCTest
@testable import UiApp

class URLRequestExtesnsionTests: XCTestCase {

    func testThatURLSessionExtendedMethodCanSetMultipartData() {
        var request = URLRequest(url: URL(string: "google.com")!)
        
        try? request.setMultipartFormData(["Login" : "TestUser"], encoding: .utf8)
        
        XCTAssertNotNil(request.httpBody)
    }
    
}
