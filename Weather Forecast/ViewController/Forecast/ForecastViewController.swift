//
//  ForecastViewController.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.getLocalForecast()
        viewModel?.didGetWeather = { [weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: ForecastTableViewCell.id, bundle: nil),  forCellReuseIdentifier: ForecastTableViewCell.id)
        tableView.tableFooterView = UIView()
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.weatherModel?.daily.count ?? viewModel?.localWeatherForecast?.count ??  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !(viewModel?.weatherModel?.daily.isEmpty ?? false), let daily =  viewModel?.weatherModel?.daily[indexPath.row] ?? viewModel?.localWeatherForecast?[indexPath.row] else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.id, for: indexPath) as! ForecastTableViewCell
        cell.setContent(dailyWheater: daily )
        return cell
    }
}


extension ForecastViewController: WeatherForecaastDelegate {
    func updateforecast(cordinates: CoordCity) {
        viewModel?.currentCoordinates = cordinates
    }
}
