//
//  DateHelper.swift
//  meteo
//
//  Created by christophe milliere on 19/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class DateHelper {
    static let get = DateHelper()
    
    func time(_ string: String) -> String? {
        if let date = convertStringDate(string) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return nil
    }
    
    func dayWeek(_ string: String) -> String? {
        if let date = convertStringDate(string) {
            let calendar = Calendar.current
            if calendar.isDateInToday(date){
                return "Aujourd'hui"
            } else if calendar.isDateInTomorrow(date) {
                return "Demain"
            } else {
                let day = calendar.component(.weekday, from: date)
                switch day {
                case 1: return "Dimanche"
                case 2: return "Lundi"
                case 3: return "Mardi"
                case 4: return "Mercredi"
                case 5: return "Jeudi"
                case 6: return "Vendredi"
                default: return "Samedi"
                }
            }
        }
        return nil
    }
    
    func convertStringDate(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = ("yyy-MM-dd HH:mm:ss")
        if let date = formatter.date(from: string) {
            return date
        }else{
            return nil
        }
    }
    
}
