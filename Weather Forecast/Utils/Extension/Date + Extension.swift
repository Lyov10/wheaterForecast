//
//  String + Extension.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import Foundation

extension Date {
     func dateFormater(date: TimeInterval, dateFormat: String) -> String {
        let dateText = Date(timeIntervalSince1970: date )
        let formater = DateFormatter()
        formater.dateFormat = dateFormat
        return formater.string(from: dateText)
        
    }
}
