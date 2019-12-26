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
    
    func testSearchBarEnterText() {
        weatherHomeViewController.searchBar(weatherHomeViewController.searchBar, textDidChange: "Singapore")
       
        
//        XCTAssertEqual(weatherHomeViewController.locationArray.count, 1)
    }
    
    
    
    


}
