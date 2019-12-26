//
//  WeatherDetailViewControllerTests.swift
//  Weather AppTests
//
//  Created by Yalamandarao Inaganti on 26/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import XCTest

@testable import Weather_App

class WeatherDetailViewControllerTests: XCTestCase {
    
     var weatherDetailViewController: WeatherDetailViewController!

    override func setUp() {
        super.setUp()
        weatherDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WeatherDetailViewControllerID") as? WeatherDetailViewController
        weatherDetailViewController.loadView()
    }


   func testWeatherDetialViewControllerNotNil() {
       
       XCTAssertNotNil(weatherDetailViewController, "Weather Detail View Contoller can't be nil")
       
   }
    
    override func tearDown() {
        super.tearDown()
        weatherDetailViewController = nil
    }

}
