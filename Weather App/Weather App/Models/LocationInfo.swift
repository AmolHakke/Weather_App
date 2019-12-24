//
//  LocationInfo.swift
//  Weather App
//
//  Created by Yalamandarao Inaganti on 24/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import UIKit

class LocationInfo: NSObject {
    
      var areaName: String!
      var country: String!
      var latitude: String!
      var longitude: String!
      var population: String!
      var region: String!
      var WeatherUrl: String!
    
    func initWithLocationInfoResult(l_areaName: String!, l_country: String!, l_latitude: String!, l_longitude: String!, l_population: String, l_region: String!, l_WeatherUrl: String ) -> Self {
        
        self.areaName = l_areaName
        self.country = l_country
        self.latitude = l_latitude
        self.longitude = l_longitude
        self.population = l_population
        self.region = l_region
        self.WeatherUrl = l_WeatherUrl
        
        return self
        
    }
    
}

