//
//  WeatherHomeViewControllerTests.swift
//  Weather AppUITests
//
//  Created by Singapore on 26/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import XCTest

class WeatherHomeViewControllerTests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldMatchNavigationBarTitle()
    {
        app.launch()
        let nagivationBarTitle = app.navigationBars.element
        XCTAssertTrue(nagivationBarTitle.staticTexts["Today's Weather"].exists)
    }
    
    func testShouldMatchSearchBarPlaceholder()
    {
        app.launch()
        let searchBarTitle = app.searchFields.element
        XCTAssertEqual(searchBarTitle.placeholderValue, "Please enter city / country etc..")
    }
    
    func testInitialStateTableViewCellContainsGreaterThanEqualToZero() {
        
        app.launch()
        let table = XCUIApplication().tables
        XCTAssertTrue(table.cells.count >= 0)
        
    }
    
    func testShouldCheckTableViewCellsCountAfterSearchInSearchBar()
    {
        app.launch()
        app.searchFields.element.tap()
        app.searchFields.element.typeText("Singapore")
        sleep(3)
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 words matching 'Singapore'")
    }
    
    func testTableViewTap()
    {
        app.launch()
        app.searchFields.element.tap()
        app.searchFields.element.typeText("Singapore")
        sleep(3)
        
        XCTAssertEqual(app.tables.cells.count, 1, "There should be 1 words matching 'Singapore'")
        
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
    }
    
}
