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
        let locationInfoMock = LocationInfo().initWithLocationInfoResult(l_areaName: "Punggol", l_country: "Singapore", l_latitude: "3.93", l_longitude: "5.09", l_population: "0", l_region: "", l_WeatherUrl: "https://www.mockurl.com")
        weatherDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WeatherDetailViewControllerID") as? WeatherDetailViewController
        weatherDetailViewController.locationInfo = locationInfoMock
        weatherDetailViewController.viewDidLoad()
        sleep(3)
    }


   func testWeatherDetialViewControllerNotNil() {
       
       XCTAssertNotNil(weatherDetailViewController, "Weather Detail View Contoller can't be nil")
   }
    
    override func tearDown() {
        super.tearDown()
        weatherDetailViewController = nil
    }

}
