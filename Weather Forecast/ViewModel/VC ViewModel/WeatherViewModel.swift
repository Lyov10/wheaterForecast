//
//  WeatherViewModel.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject {
    var didGetWeather : (() -> ()) = {}
    var weatherModel: WeatherModel?
    var localWeatherForecast: [Daily]?
    var cityModel: CityModel?
    var currentCoordinates: CoordCity? {
        didSet {
            getWeather(completion: {[weak self]  in
                guard let self = self else {return}
                self.didGetWeather()
            })
        }
    }
    

    func getWeather(completion: @escaping () -> Void) {
        WeatherRequestManager.sharedInstance.getWeather(latitude: String(currentCoordinates?.lat ?? 53.9024716), longitude: String(currentCoordinates?.lon ?? 27.5618225), complation: {[weak self] weather in
            guard let self = self else {return}
            self.weatherModel = weather
            if let encodeWheather = try?  PropertyListEncoder().encode(weather?.daily) {
                UserDefaults.standard.set(encodeWheather, forKey: Constants.Userdefaults.localWeatherForecast)
            }
            completion()
        })
    }
    func saveLocation(_ location: CLLocationCoordinate2D ) {
        let cordinates = CoordCity(lat: location.latitude, lon: location.longitude)
        currentCoordinates = cordinates
    }
    
    func getLocalForecast() {
        guard let storedObject: Data = UserDefaults.standard.data(forKey: Constants.Userdefaults.localWeatherForecast) else {return}
        guard let localForecast: [Daily] = try? PropertyListDecoder().decode([Daily].self, from: storedObject) else {return}
        localWeatherForecast = localForecast
    }
    
}

