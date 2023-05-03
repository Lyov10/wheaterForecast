//
//  SearchTableViewCell.swift
//  Weather Forecast
//
//  Created by 4steps on 03.05.23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let id = "SearchTableViewCell"
    @IBOutlet weak var cityLabel: UILabel!
    
    func setupContent(model: CityModel) {
        cityLabel.text = model.name
    }
    
}
