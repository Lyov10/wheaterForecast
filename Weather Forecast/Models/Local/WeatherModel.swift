//
//  WeatherModel.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import Foundation

class WeatherModel: Codable {
    let lat,lon: Double?
    let hourly: [Hourly]
    let daily: [Daily]
    let current: Hourly
}


class Daily: Codable {
    let dt: TimeInterval
    let weather: [WeatherIcon]
    let temp: Temp
}

class Hourly: Codable {
    let dt: TimeInterval
    let weather: [WeatherIcon]
    let temp: Double
}

class WeatherIcon: Codable {
    let icon: String
    let main: String
    let description: String
}

class Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
}
