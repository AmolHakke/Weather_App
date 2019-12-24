//
//  LocationDetailService.swift
//  Weather App
//
//  Created by Yalamandarao Inaganti on 24/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import Foundation

class LocationDetailService {
    
    var detailFetchTask: URLSessionDataTask?
    
    func getLocationCurrentWeather(locationInfo: LocationInfo, completionHandler: @escaping((LocationCurrentWeatherInfo) ->
        ()),  errorHandler: @escaping (()->Void)) {
        
        let urlString = URL(string: "\(AppConstants.baseURL)weather.ashx?key=\(AppConstants.premiumAPIKey)&q=\(String(locationInfo.latitude)),\(String(locationInfo.longitude))&format=json")
        
        if let url = urlString {
            
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                errorHandler()
                return
            }
            do {
                let jsonResult:AnyObject =  (try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary)!
                print(jsonResult)
                   guard let dataJson = jsonResult["data"] as? [String: Any],
                               let currentConditionArray = dataJson["current_condition"] as? [[String: Any]],
                              
                               let conditionObject = currentConditionArray.first,
                               let tempc = conditionObject["temp_C"] as? String,
                    
                               let humidity = conditionObject["humidity"] as? String,
                    
                               let weatherIconUrlArray = conditionObject["weatherIconUrl"] as? [[String: Any]],
                               let weatherIconUrlObj = weatherIconUrlArray.first,
                               let weatherIconUrl = weatherIconUrlObj["value"] as? String,
                    
                               let weatherDescArray = conditionObject["weatherDesc"] as? [[String: Any]],
                               let descObject = weatherDescArray.first,
                               let weatherDesc = descObject["value"] as? String else {
                                   errorHandler()
                                   return
                           }
                        let locationDetail =  LocationCurrentWeatherInfo().initWithLocationCurrentWeatherInfo(l_weatherIconUrl: weatherIconUrl, l_humidity: humidity, l_temp_C: tempc, l_weatherDesc: weatherDesc)
                           completionHandler(locationDetail)
          
            }
            catch _ as NSError {
                errorHandler()
            }
            
        }
            detailFetchTask?.cancel()
            detailFetchTask = task
            detailFetchTask?.resume()
        }
        
    }
}
