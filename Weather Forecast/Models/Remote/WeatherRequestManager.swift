//
//  WeatherRequestManager.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import UIKit
import Alamofire

class WeatherRequestManager {
    public static let sharedInstance = WeatherRequestManager()
    var sessionManager: Session
    
    private init() {
        sessionManager = Session(configuration: URLSessionConfiguration.default)
    }
    
    func getWeather(latitude : String, longitude : String, complation: @escaping (_ response: WeatherModel?)->()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&lang=ru&exclude=minutely&units=metric&appid=\(Constants.Key.apiId)") else {
            complation(nil)
            return
        }
//        "https://api.openweathermap.org/data/2.5/onecall?lat=53.9024716&lon=27.5618225&exclude=minutely&units=metric&appid=1c2ba745810db56a9f945361a2520a0a"
        WeatherRequestManager.sharedInstance.sessionManager.request(url, method: .get ,encoding: URLEncoding.default).responseJSON { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                do {
                    let resultData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let response = try JSONDecoder().decode(WeatherModel.self, from: resultData)
                    complation(response)
                } catch {
                    print(error);   complation(nil)
                }
            case .failure(let error):
                print(error);   complation(nil)
            }
        }
    }
    
    
    
}
