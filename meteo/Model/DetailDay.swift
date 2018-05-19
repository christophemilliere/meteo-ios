//
//  DetailDay.swift
//  meteo
//
//  Created by christophe milliere on 19/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class DetailDay {
    
    private var _day: String
    private var _icon: String
    private var _min: Double
    private var _max: Double
    private var _desc: String
    
    var day: String {
        return _day
    }
    var icon: String {
        return _icon
    }
    var min: Double {
        return _max
    }
    
    var max: Double {
        return _max
    }
    var desc: String {
        return _desc
    }
    
    init(day: String, icon: String, min: Double, max: Double, desc: String ) {
        self._day = day
        self._icon = icon
        self._min = min
        self._max = max
        self._desc = desc
    }
}
