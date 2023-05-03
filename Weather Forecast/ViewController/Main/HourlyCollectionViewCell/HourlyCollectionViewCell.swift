//
//  HourlyCollectionViewCell.swift
//  Weather Forecast
//
//  Created by 4steps on 03.05.23.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

   static let id = "HourlyCollectionViewCell"

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temeratureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setupContent(model: Hourly) {
        weatherImage.image = UIImage(named: "\(model.weather.first!.icon)-1.png")
        temeratureLabel.text = "\(Int(model.temp))° C"
        timeLabel.text = Date().dateFormater(date: (model.dt), dateFormat: "HH:hh")
    }
}
