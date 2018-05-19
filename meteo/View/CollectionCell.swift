//
//  CollectionCell.swift
//  meteo
//
//  Created by christophe milliere on 13/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    var forecast: Forecast!
    
    func setup(forecast: Forecast) {
        self.forecast = forecast
        layer.cornerRadius = 20
        
        ImageDownloader.getImage.imageSince(self.forecast.icon, imageView: icon)
        temperature.text = self.forecast.temperature.convertIntString()
        desc.text = self.forecast.day + "  " + (DateHelper.get.time(self.forecast.date) ?? "") + "\n" + self.forecast.desc
    }
}
