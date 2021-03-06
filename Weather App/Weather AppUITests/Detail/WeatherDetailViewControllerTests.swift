//
//  WeatherDetailViewControllerTests.swift
//  Weather AppUITests
//
//  Created by Yalamandarao Inaganti on 26/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import XCTest

class WeatherDetailViewControllerTests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
         app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldNagivationBarContainRigthBarButton()
      {
          app.launch()
          app.searchFields.element.tap()
          app.searchFields.element.typeText("Singapore")
          sleep(3)
        
          let firstCell = app.tables.cells.element(boundBy: 0)
          firstCell.tap()
          sleep(3)
          let rightNavBarButton = app.navigationBars.children(matching: .button).firstMatch
          XCTAssert(rightNavBarButton.exists)
          
      }

}
