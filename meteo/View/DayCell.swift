//
//  DayCell.swift
//  meteo
//
//  Created by christophe milliere on 19/05/2018.
//  Copyright © 2018 christophe milliere. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    var day: DetailDay!
    
    func setup(forecast: DetailDay) {
        day = forecast
        ImageDownloader.getImage.imageSince(day.icon, imageView: icon)
        let attributed = NSMutableAttributedString(string: day.day + "\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 22), .foregroundColor: UIColor.black])
        let descString = NSMutableAttributedString(string: day.desc + "\n", attributes: [.font: UIFont.italicSystemFont(ofSize: 20), .foregroundColor: UIColor.black])
        
        let temperature = NSMutableAttributedString(string: "min : " + day.min.convertIntString() + " - Max: " + day.max.convertIntString(), attributes: [.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.black])
        
        attributed.append(descString)
        attributed.append(temperature)
        labelText.attributedText = attributed
        
    }
}
