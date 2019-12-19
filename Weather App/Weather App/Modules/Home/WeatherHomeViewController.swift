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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension WeatherHomeViewController : UITableViewDelegate, UITableViewDataSource
{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
       {
           return 20
       }
       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell:WeatherCustomCell = tableView.dequeueReusableCell(withIdentifier: "WeatherCustomCellID") as! WeatherCustomCell
           cell.cityLabel?.text = "Punggol"
           cell.countyLabel?.text = "Singapore"
           cell.weatherImageView?.image = UIImage(named: "weather_placeholer")
           
           return cell
        }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 100.0
        }
}

