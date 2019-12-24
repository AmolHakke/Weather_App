//
//  LocationInfoTests.swift
//  Weather AppTests
//
//  Created by Yalamandarao Inaganti on 25/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import XCTest

@testable import Weather_App

class LocationInfoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAreaNameMatch() throws {
        
        // Given
        let locationInfo = LocationInfo().initWithLocationInfoResult(l_areaName: "Punggol", l_country: "Singapore", l_latitude: "3.93", l_longitude: "5.09", l_population: "0", l_region: "", l_WeatherUrl: "https://www.worldweatheronline.com/v2/weather.aspx?q=1.3361,103.975")
        
        // Then
        let locationInfoWrap = try XCTUnwrap(locationInfo)
        XCTAssertEqual(locationInfoWrap.areaName, "Punggol")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
