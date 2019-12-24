//
//  WeatherHomeViewController.swift
//  Weather App
//
//  Created by Yalamandarao Inaganti on 19/12/19.
//  Copyright © 2019 Yalamandarao Inaganti. All rights reserved.
//

import UIKit
import SQLite3

class WeatherHomeViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let locationSerarchService = LocationSearchService()
    
    private var locationArray = NSMutableArray()
    
    private var locationInfoObj = LocationInfo()
    
    var db:CustomDB = CustomDB()
    
    var locationIn:[LocationInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Prepare Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherDetailViewControllerSegue" {
            if segue.destination.isKind(of: WeatherDetailViewController.self) {
                let secondVC = segue.destination as! WeatherDetailViewController

                let indexPath = sender as! IndexPath
                secondVC.locationInfo = locationArray[indexPath.row] as! LocationInfo
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    //MARK:- Get previously viewed any city's weather
    func getViewedCitiesList() {
        locationIn = db.read()
        print("LocationIn count : \(locationIn.count)")
        self.locationArray =  NSMutableArray()
        for item in locationIn {
           self.locationArray.add(item)
        }
          DispatchQueue.main.async {
              self.weatherTableView.reloadData()
          }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.getViewedCitiesList()
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
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            performSegue(withIdentifier: "WeatherDetailViewControllerSegue", sender: indexPath)
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
            
            self.locationArray =  NSMutableArray()
            self.locationArray = resultArray
            
            if self.locationArray.count > 0
            {
                DispatchQueue.main.async {
                   self.weatherTableView.reloadData()
                }
            }
            else
            {
                self.getViewedCitiesList()
            }
           
       }, errorHandler: {
                 self.locationArray =  NSMutableArray()
                 DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                 }
            })
    }
}


