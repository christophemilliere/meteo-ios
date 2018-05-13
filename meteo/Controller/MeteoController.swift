//
//  MeteoController.swift
//  meteo
//
//  Created by christophe milliere on 13/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class MeteoController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var iconTempCurrent: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descTempCurrent: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "forecastCell"
    
    
    var locationManager: CLLocationManager?
    var forecast = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getWeatherForecast(lat: Double, lng: Double){
        let urlBase = "http://api.openweathermap.org/data/2.5/forecast?"
        let latitude = "lat=\(String(lat))"
        let longitude = "&lon=\(String(lng))"
        let unitAndLang = "&units=metric&lang=fr"
        let keyApi = "&APPID=\(API)"
        let urlString = urlBase + latitude + longitude + unitAndLang + keyApi
        guard let url  = URL(string: urlString) else { return }
        Alamofire.request(url).responseJSON { (response) in
            if let data = response.value as? [String: AnyObject] {
                if let infoCity = data["city"] as? [String: AnyObject], let name = infoCity["name"] as? String {
                    self.labelTitle.text = name
                    if let  list = data["list"] as? NSArray {
                        for element in list {
                            if let dictionnary = element as? [String: AnyObject] {
                                if let main = dictionnary["main"] as? [String: AnyObject] {
                                    if let temp = main["temp"] as? Double {
                                        if let weather = dictionnary["weather"] as? NSArray, weather.count > 0 {
                                            if let tempCurrent = weather[0] as? [String: AnyObject] {
                                                if let desc = tempCurrent["description"] as? String {
                                                    if let icon = tempCurrent["icon"] as? String {
                                                        if let date  = dictionnary["dt_txt"] as? String {
                                                            let newForecast = Forecast(temperature: temp, date: date, desc: desc, icon: icon)
                                                            self.forecast.append(newForecast)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        // loading data
                        self.setupValueMoment()
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func setupValueMoment() {
        if forecast.count > 0 {
            let tempsCurrent = forecast[0]
            temperatureLabel.text = tempsCurrent.temperature.convertIntString()
            descTempCurrent.text = tempsCurrent.desc
            ImageDownloader.getImage.imageSince(tempsCurrent.icon, imageView: iconTempCurrent)
        }
    }
}


