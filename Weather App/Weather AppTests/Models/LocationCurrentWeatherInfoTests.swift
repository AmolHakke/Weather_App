//
//  LocationCurrentWeatherInfoTests.swift
//  Weather AppTests
//
//  Created by Yalamandarao Inaganti on 26/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import XCTest

@testable import Weather_App

class LocationCurrentWeatherInfoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHumidityMatch()
    {
        let locationCurrentWeatherInfo = LocationCurrentWeatherInfo().initWithLocationCurrentWeatherInfo(l_weatherIconUrl: "https://google.com", l_humidity: "60", l_temp_C: "30", l_weatherDesc: "Cloudly")
        
        XCTAssertEqual(locationCurrentWeatherInfo.humidity, "60")
    }

   

}
