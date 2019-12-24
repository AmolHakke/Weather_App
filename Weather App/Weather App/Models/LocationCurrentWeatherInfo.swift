//
//  LocationCurrentWeatherInfo.swift
//  Weather App
//
//  Created by Yalamandarao Inaganti on 24/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import Foundation

class LocationCurrentWeatherInfo: NSObject {
    
      var weatherIconUrl: String!
      var humidity: String!
      var temp_C: String!
      var weatherDesc: String!
    
    func initWithLocationCurrentWeatherInfo(l_weatherIconUrl: String!, l_humidity: String!, l_temp_C: String!, l_weatherDesc: String!) -> Self {
        
        self.weatherIconUrl = l_weatherIconUrl
        self.humidity = l_humidity
        self.temp_C = l_temp_C
        self.weatherDesc = l_weatherDesc
        
        return self
        
    }
    
}
