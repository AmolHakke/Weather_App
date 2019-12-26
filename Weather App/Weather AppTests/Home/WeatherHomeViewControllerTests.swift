//
//  WeatherHomeViewControllerTests.swift
//  Weather AppTests
//
//  Created by Yalamandarao Inaganti on 25/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import XCTest

@testable import Weather_App

class WeatherHomeViewControllerTests: XCTestCase {
    
    var weatherHomeViewController: WeatherHomeViewController!
    
    override func setUp() {
        super.setUp()
        weatherHomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WeatherHomeViewControllerID") as? WeatherHomeViewController
        weatherHomeViewController.loadView()
    }
    
    override func tearDown() {
        super.tearDown()
        weatherHomeViewController = nil
    }
    
    func testWeatherHomeViewControllerNotNil() {
        
        XCTAssertNotNil(weatherHomeViewController, "Weather Home View Contoller can't be nil")
        
    }
    
    func testWeatherDetailViewControllerSegueExist() {
        
        let identifiers = segues(ofViewController: weatherHomeViewController)
        XCTAssertTrue(identifiers.contains("WeatherDetailViewControllerSegue"), "Segue WeatherDetailViewControllerSegue should exist.")
    }
    
    func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.compactMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
    
    // MARK: - SearchBar
    
    func testHasSearchBar() {
        
        XCTAssertNotNil(weatherHomeViewController.searchBar)
    }
    
    func testShouldSetSearchBarDelegate() {
        
        XCTAssertNotNil(weatherHomeViewController.searchBar.delegate)
    }
    
    func testDefinesTargetSearchTextAfterSearchButtonTapped() {
        weatherHomeViewController.searchBar.text = "Singapore"
        weatherHomeViewController.searchBarSearchButtonClicked(weatherHomeViewController.searchBar)
        
        let expectedTargetSearchText = "Singapore"
        let actualTargetSearchText = weatherHomeViewController.searchBar.text
        
        XCTAssertEqual(expectedTargetSearchText, actualTargetSearchText)
    }
    
    func testSegueShouldPerformSegueFalse()
    {
        XCTAssertFalse(weatherHomeViewController.shouldPerformSegue(withIdentifier: "WeatherDetailViewControllerSegue", sender: self))
    }
    
    func testGetLocationArrayCountEqualToOne() {
        weatherHomeViewController.searchBar(weatherHomeViewController.searchBar, textDidChange: "Singapore")
        sleep(3)
        XCTAssertEqual(weatherHomeViewController.locationArray.count, 1)
    }
    
    func testControllerHasTableView() {
        XCTAssertNotNil(weatherHomeViewController.weatherTableView, "Controller should have a tableview")
    }
    
    func testTableViewShouldDisplayOneRecord() {
        
        weatherHomeViewController.searchBar(weatherHomeViewController.searchBar, textDidChange: "Singapore")
        sleep(3)
        let tableView = UITableView()
        
        let numberOfRows = weatherHomeViewController.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1,
                       "Number of rows in table should match number")
    }
    
    func testTableCellHeightCheck() {
        
          let tableView = UITableView()
          let tableviewCellHight = weatherHomeViewController.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0))
          
          XCTAssertEqual(tableviewCellHight, 100,
                         "Tableview cell height should be 100.")
      }
    
    func testTableViewDelegateIsWeatherHomeViewController() {
        XCTAssertTrue(weatherHomeViewController.weatherTableView.delegate === weatherHomeViewController, "Controller should be delegate for the table view")
    }
    
    func testTableViewHasCells() {
        let cell = weatherHomeViewController.weatherTableView.dequeueReusableCell(withIdentifier: "WeatherCustomCellID")
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'WeatherCustomCellID'")
    }
    
    func testSelectingCell() {
           
           weatherHomeViewController.searchBar(weatherHomeViewController.searchBar, textDidChange: "Singapore")
           sleep(3)
           let tableView = UITableView()
        weatherHomeViewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        let locationInfo: LocationInfo = weatherHomeViewController.locationArray[0] as! LocationInfo
        
        XCTAssertEqual(locationInfo.country, "Singapore")
        
       }
    
    func testCellForRow() {
        
        weatherHomeViewController.searchBar(weatherHomeViewController.searchBar, textDidChange: "Singapore")
        
        sleep(3)
        
        let tableView = UITableView()
        tableView.register(WeatherCustomCell.self, forCellReuseIdentifier: "WeatherCustomCellID")
        sleep(2)
         weatherHomeViewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(weatherHomeViewController.locationInfoObj.country, "Singapore",
                       "The first cell should display country name of Singapore")
    }
    
}

