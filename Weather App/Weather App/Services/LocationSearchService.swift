//
//  LocationSearchService.swift
//  Weather App
//
//  Created by Yalamandarao Inaganti on 24/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import Foundation

import Foundation

class LocationSearchService {
    
    var searchTask: URLSessionDataTask?
    //https://www.freecodecamp.org/news/how-to-make-your-first-api-call-in-swift/
    
    func getLocations(locationName: String, completionHandler: @escaping((NSMutableArray) ->
        ()),  errorHandler: @escaping (()->Void)) {
        
        let urlString = URL(string: "\(AppConstants.baseURL)search.ashx?query=\(locationName)&num_of_results=3&format=json&key=\(AppConstants.premiumAPIKey)")
        if let url = urlString {
            
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                errorHandler()
                return
            }
            do {
                let jsonResult:AnyObject =  (try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary)!
                
                print(jsonResult)
                
                var locationInfoObjects: NSMutableArray = []
                  
                
                guard let searchApiJson = jsonResult["search_api"] as? [String: Any],
                                       let resultArray = searchApiJson["result"] as? [[String: Any]] else {
                                           locationInfoObjects = NSMutableArray()
                                           completionHandler(locationInfoObjects)
                                           return
                                   }
                                   for resultJson in resultArray {
                                     
                                       guard let areaNameArray = resultJson["areaName"] as? [[String: Any]],
                                           let areaNameObject = areaNameArray.first,
                                           let areaName = areaNameObject["value"] as? String,
                                           
                                           let regionJsonArray = resultJson["region"] as? [[String: Any]],
                                           let regionObject = regionJsonArray.first,
                                           let region = regionObject["value"] as? String,
                                           
                                           let countryJsonArray = resultJson["country"] as? [[String: Any]],
                                           let countryObject = countryJsonArray.first,
                                           let country = countryObject["value"] as? String,
                                        
                                           let weatherUrlArray = resultJson["weatherUrl"] as? [[String: Any]],
                                           let weatherObject = weatherUrlArray.first,
                                           let weatherUrl = weatherObject["value"] as? String,
                                           
                                           let latitude = resultJson["latitude"] as? String,
                                           let longitude = resultJson["longitude"] as? String,
                                           let population = resultJson["population"] as? String else {
                                           continue
                                       }
                                    let locationInfo = LocationInfo().initWithLocationInfoResult(l_areaName: areaName, l_country: country, l_latitude: latitude, l_longitude: longitude, l_population: population, l_region: region, l_WeatherUrl: weatherUrl)
                                      
                                       locationInfoObjects.add(locationInfo)
                                   }
                                   completionHandler(locationInfoObjects)
                
            }
            catch _ as NSError {
                errorHandler()
            }
            
        }
            searchTask?.cancel()
            searchTask = task
            searchTask?.resume()
        }
        
    }
}
