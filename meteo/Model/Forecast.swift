//
//  Forecast.swift
//  meteo
//
//  Created by christophe milliere on 13/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class Forecast{
    private var _temperature: Double
    private var _date: String
    private var _icon: String
    private var _desc: String
    private var _day: String
    
    var temperature: Double {
        return _temperature
    }
    var date: String {
        return _date
    }
    var icon: String{
        return _icon
    }
    var desc: String {
        return _desc
    }
    var day: String {
        return _day
    }
    
    init(temperature: Double, date: String, desc: String, icon: String) {
        self._temperature = temperature
        self._date = date
        self._icon = icon
        self._desc = desc
        self._day = ""
    }
    
}
