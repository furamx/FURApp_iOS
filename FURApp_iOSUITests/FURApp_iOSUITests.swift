//
//  FURApp_iOSUITests.swift
//  FURApp_iOSUITests
//
//  Created by Eduardo Aguilera Olascoaga on 11/7/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import XCTest

class FURApp_iOSUITests: XCTestCase {
    var app:XCUIApplication!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app=XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatSignInButtonExists() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //Verify that button with text "¡Únete y participa!" exists
        XCTAssertTrue(app.buttons["¡Únete y participa!"].exists)
    }
//    func testThatNavigatesToSignInView(){
//        //Simulates the action to navigate on the Sign In view
//        let button=app.buttons["¡Únete y participa!"]
//        button.tap()
//        //Waits for the view to appear
//        //waitForExpectations(timeout: 10, handler: nil)
//        //Verify that element is displayed
//        let counter = app.menuItems.count > 0
//        XCTAssertTrue(counter)
//    }
}

//extension XCUIApplication {
//    var isDisplayingAuthViewController: Bool {
//        //Search for the element with the identifier
//        return otherElements["authViewController"].exists
//    }
//}

