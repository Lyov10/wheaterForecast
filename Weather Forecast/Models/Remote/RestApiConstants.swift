//
//  RestApiConstants.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import Foundation

struct RestAPIConstants {
    static let baseUrl = "https://api.openweathermap.org/"
    static let baseVersion = "data/2.5/onecall?"
    
    struct Weather {
        
        static let fullUrl = baseUrl + baseVersion
        
    }
}
