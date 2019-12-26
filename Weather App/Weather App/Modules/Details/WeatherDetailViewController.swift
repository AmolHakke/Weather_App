//
//  WeatherDetailViewController.swift
//  Weather App
//
//  Created by Yalamandarao Inaganti on 19/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var weatherIconImage : UIImageView!
    
    @IBOutlet weak var humidityLabel : UILabel!
    
    @IBOutlet weak var tempcLabel : UILabel!
    
    @IBOutlet weak var weatherDescLabel : UILabel!
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?
    
    let locationDetailService = LocationDetailService()
    
    var locationInfo = LocationInfo()
    
    var db:CustomDB = CustomDB()
    
    private var locationDetailInfoObj = LocationCurrentWeatherInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocationDetail()
    }
    
    func setupUI() {
        
        activityIndicator?.stopAnimating()
        self.weatherDescLabel.text = "Weather Desc : " + self.locationDetailInfoObj.weatherDesc
        self.tempcLabel.text = "Temp C :" + self.locationDetailInfoObj.temp_C + " C"
        self.humidityLabel.text = "Humidity :" + self.locationDetailInfoObj.humidity + " %"
        print("LocationURL  " + self.locationDetailInfoObj.weatherIconUrl)
        
        if !(self.locationDetailInfoObj.weatherIconUrl ?? "").isEmpty
        {
             self.weatherIconImage.load(url: URL(string: self.locationDetailInfoObj.weatherIconUrl)!)
        }
       
        db.insert(areaName: self.locationInfo.areaName, country: self.locationInfo.country, latitude: self.locationInfo.latitude, longitude: self.locationInfo.longitude, population: self.locationInfo.population, region: self.locationInfo.region, WeatherUrl: self.locationInfo.WeatherUrl)
    }
    
    func fetchLocationDetail() {
        activityIndicator?.startAnimating()
        locationDetailService.getLocationCurrentWeather(locationInfo: locationInfo, completionHandler: { locationDetailInfo in
            self.locationDetailInfoObj = locationDetailInfo
            
            DispatchQueue.main.async {
                self.setupUI()
            }
            
        }, errorHandler: {
            self.activityIndicator?.stopAnimating()
        })
        
    }
    
    
}
