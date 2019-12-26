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
        let locationInfoMock = LocationInfo().initWithLocationInfoResult(l_areaName: "Punggol", l_country: "Singapore", l_latitude: "3.93", l_longitude: "5.09", l_population: "0", l_region: "", l_WeatherUrl: "https://www.mockurl.com")
        
        // Then
        let locationInfoWrap = try XCTUnwrap(locationInfoMock)
        XCTAssertEqual(locationInfoWrap.areaName, "Punggol")
    }
    
    func testShouldCountryIsEmpty()
    {
        // Given
        let locationInfoMock = LocationInfo().initWithLocationInfoResult(l_areaName: nil, l_country: nil, l_latitude: nil, l_longitude: nil, l_population: nil, l_region: nil, l_WeatherUrl:nil)
        
        XCTAssertTrue(locationInfoMock.country.isEmpty)
    }
    
}
