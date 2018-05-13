//
//  Extension.swift
//  meteo
//
//  Created by christophe milliere on 13/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import Foundation

extension Double {
    func convertIntString() -> String {
        let int = Int(self)
        return String(int) + "°C"
        
    }
}
