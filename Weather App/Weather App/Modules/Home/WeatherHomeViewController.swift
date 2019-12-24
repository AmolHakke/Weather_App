//
//  WeatherHomeViewController.swift
//  Weather App
//
//  Created by Yalamandarao Inaganti on 19/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import UIKit

class WeatherHomeViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let locationSerarchService = LocationSearchService()
    
    private var locationArray = NSMutableArray()
    
    private var locationInfoObj = LocationInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension WeatherHomeViewController : UITableViewDelegate, UITableViewDataSource
{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
       {
        return self.locationArray.count
       }
       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell:WeatherCustomCell = tableView.dequeueReusableCell(withIdentifier: "WeatherCustomCellID") as! WeatherCustomCell
            locationInfoObj = locationArray.object(at: indexPath.row) as! LocationInfo
            cell.cityLabel?.text = locationInfoObj.areaName
            cell.countyLabel?.text = locationInfoObj.country
            cell.weatherImageView?.image = UIImage(named: "weather_placeholer")
            return cell
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 100.0
        }
}

extension WeatherHomeViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        locationSerarchService.getLocations(locationName: searchText, completionHandler: { resultArray in
            
            self.locationArray = resultArray
            
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
       }, errorHandler: {
                 self.locationArray =  NSMutableArray()
                 DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                 }
            })
    }
}


