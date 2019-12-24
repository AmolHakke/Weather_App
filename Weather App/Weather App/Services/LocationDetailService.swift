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
    
    func getLocations(locationName: String, completionHandler: @escaping((NSMutableArray) ->
        ()),  errorHandler: @escaping (()->Void)) {
        

        let urlString = URL(string: "\(AppConstants.baseURL)weather.ashx?key=\(AppConstants.premiumAPIKey)&q=48.85,2.35&format=json")
        if let url = urlString {
            
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                errorHandler()
                return
            }
            do {
                let jsonResult:AnyObject =  (try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary)!
                
                print(jsonResult)
                
               
                
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
