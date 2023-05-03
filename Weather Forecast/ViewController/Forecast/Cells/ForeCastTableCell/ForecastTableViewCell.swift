//
//  ForecastTableViewCell.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let id = "ForecastTableViewCell"

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var wheaterImage: UIImageView!
    
    func setContent(dailyWheater: Daily) {
        dayLabel.text =  Date().dateFormater(date: (dailyWheater.dt), dateFormat: "dd MMM")
        descriptionLabel.text = dailyWheater.weather.first?.main
        temperatureLabel.text = "\(Int(dailyWheater.temp.day))° C"
        wheaterImage.image = UIImage(named: "\(dailyWheater.weather.first!.icon)-1.png")
    }
}
