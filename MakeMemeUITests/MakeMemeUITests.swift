//
//  MakeMemeUITests.swift
//  MakeMemeUITests
//
//  Created by Cathy Oun on 4/2/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import XCTest
import UITestUtils

class MakeMemeUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
    func testExample() {
        let app = XCUIApplication()

        app.launch()

        app.navigationBars["Sent Memes"].buttons["Add"].tap()
//        app.toolbars.buttons["Pick an Image"].tap()
//        app.tables.buttons["Moments"]s.tap()
        
        
        
//        let app = XCUIApplication()
//        app.navigationBars["Sent Memes"].buttons["Add"].tap()
//        app.toolbars.buttons["Pick an Image"].tap()
//        app.tables.buttons["Moments"].tap()
//        app.collectionViews["PhotosGridView"].cells["Photo, Portrait, April 02, 5:22 PM"].tap()
//        waitForDuration(2)
        saveScreenshot("\(realHomeDirectory)/Temp/Screenshots/some_screenshot.jpg")
        waitForDuration(2)
        
        
      
    }
    
}
