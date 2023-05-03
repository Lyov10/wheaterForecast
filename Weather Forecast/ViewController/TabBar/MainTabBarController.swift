//
//  MainTabBarController.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func cityChanged(lat: Double?, lon: Double?)
}

protocol WeatherForecaastDelegate: AnyObject {
    func updateforecast(cordinates: CoordCity)
}

class MainTabBarController: UITabBarController {
    
    weak  var forecastDelegate: WeatherForecaastDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        CityDataSource.shared.getCity()
        setShadow()
        prepareViewModels()
    }
    

    func setShadow() {
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.cornerRadius = 16
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
    }
    
    private func prepareViewModels() {
        
        let mainDestinationVC = viewControllers?[0] as! MainViewController
        mainDestinationVC.viewModel = WeatherViewModel()
        mainDestinationVC.delegate = self
        
        let forecastViewController = viewControllers?[2] as! ForecastViewController
        forecastViewController.viewModel = WeatherViewModel()
        forecastDelegate = forecastViewController
    }

}

extension MainTabBarController : MainTabBarControllerDelegate {
    func cityChanged(lat: Double?, lon: Double?) {
        guard let lat = lat, let lon = lon else {return}
        let forecastViewController = viewControllers?[2] as! ForecastViewController
        forecastViewController.viewModel = WeatherViewModel()
        forecastDelegate?.updateforecast(cordinates: CoordCity(lat: lat, lon: lon))
    }
    
}
