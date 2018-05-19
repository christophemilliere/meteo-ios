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
    let cellIdDay = "dayCell"
    
    
    var locationManager: CLLocationManager?
    var forecast = [Forecast]()
    var detailDay = [DetailDay]()
    var retrieveData = false
    
    var day = UIColor(red: 0, green: 191 / 255, blue: 1, alpha: 1)
    var nigth = UIColor(red: 19 / 255, green: 24 / 255, blue: 98 / 255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getWeatherForecast(lat: Double, lng: Double){
        retrieveData = true
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
                        self.getForecastDay()
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
            if tempsCurrent.icon.contains("d") {
                view.backgroundColor = day
            } else {
                view.backgroundColor = nigth
            }
        }
    }
    
    func getForecastDay(){
        var day = ""
        var icon = ""
        var min = 0.0
        var max = 0.0
        var desc = ""
        for forecast in forecast {
            if forecast.date != "" {
                if forecast.day != day {
                    if day != "" {
                        let newDay = DetailDay(day: day, icon: icon, min: min, max: max, desc: desc)
                        detailDay.append(newDay)
                    }
                    day = forecast.day
                    icon = forecast.icon
                    min = forecast.temperature
                    max = forecast.temperature
                    desc = forecast.desc
                } else {
                    if forecast.temperature > max {
                        max = forecast.temperature
                    }
                    if forecast.temperature < min {
                        min = forecast.temperature
                    }
                    if forecast.date.contains("12:") {
                        icon = forecast.icon
                        desc = forecast.desc
                    }
                }
            }
        }
        retrieveData = false
        self.tableView.reloadData()
    }
}


