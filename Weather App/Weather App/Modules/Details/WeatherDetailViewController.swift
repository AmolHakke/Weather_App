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
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    let locationDetailService = LocationDetailService()
    
    var locationInfo = LocationInfo()
      
    private var locationDetailInfoObj = LocationCurrentWeatherInfo()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           fetchLocationDetail()
       }
    
    func setupUI() {
        activityIndicator.stopAnimating()
        self.weatherDescLabel.text = "Weather Desc : " + self.locationDetailInfoObj.weatherDesc
        self.tempcLabel.text = "Temp C : \(String(describing: self.locationDetailInfoObj.temp_C)) C"
        self.humidityLabel.text = "Humidity : \(String(describing: self.locationDetailInfoObj.humidity)) %"
        print("LocationURL  " + self.locationDetailInfoObj.weatherIconUrl)
        self.weatherIconImage.load(url: URL(string: self.locationDetailInfoObj.weatherIconUrl)!)
    }
    
    func fetchLocationDetail() {
        activityIndicator.startAnimating()
        locationDetailService.getLocationCurrentWeather(locationInfo: locationInfo, completionHandler: { locationDetailInfo in
            self.locationDetailInfoObj = locationDetailInfo

            DispatchQueue.main.async {
                self.setupUI()
            }
            
        }, errorHandler: {
            self.activityIndicator.stopAnimating()
        })
        
    }
    
    
}
