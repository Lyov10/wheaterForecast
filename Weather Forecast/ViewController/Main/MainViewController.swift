//
//  MainViewController.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: WeatherViewModel?
    
    private let toSearchSegueId = "SearchViewController"
    weak var delegate : MainTabBarControllerDelegate?
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    override func viewDidLoad() {
        super.viewDidLoad()
        actualLocation()
        configureCollectionView()
        viewModel?.didGetWeather = { [weak self] in
            guard let self = self else {return}
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            self.updateUI()
            delegate?.cityChanged(lat: viewModel?.currentCoordinates?.lat, lon: viewModel?.currentCoordinates?.lon)
        }
    }
    
    func configureCollectionView() {
        collectionView.register(UINib(nibName: HourlyCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: HourlyCollectionViewCell.id)
    }
    
    func updateUI() {
        guard let model = viewModel?.weatherModel else {return}
        collectionView.reloadData()
        temperatureLabel.text = "\(Int(model.current.temp ))° C"
        weatherImage.image = UIImage(named: "\(model.current.weather.first!.icon)-1.png")
        descriptionLabel.text = model.current.weather.first?.main
        dateLabel.text = Date().dateFormater(date: (model.current.dt), dateFormat: "EEEE,MMMM dd,yyyy")
    }
    
    @IBAction func getCurrentLocationTapped(_ sender: UIButton) {
        if CLLocationManager.authorizationStatus() != .denied {
            actualLocation()
        } else {
            showLocationAlert()
        }
    }
    
    func showLocationAlert() {
        let alert = UIAlertController(title: "User location is denied", message: "To see your current location weather please enable from settings", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default)  { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { _ in })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case toSearchSegueId:
            let desitnationVC = segue.destination as! SearchViewController
            desitnationVC.delegate = self
        default:
            break
        }
    }
    
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.weatherModel?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = viewModel?.weatherModel?.hourly, !data.isEmpty else {return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.id, for: indexPath) as! HourlyCollectionViewCell
        cell.setupContent(model: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double(UIScreen.main.bounds.width - 12 - 32) / 2
        let height = 160.0
        return CGSize(width: width, height: height)
    }
    
}

extension MainViewController:  CLLocationManagerDelegate  {
    func actualLocation() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        locationManager.stopUpdatingLocation()
        let cordinates: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        geoCoder.reverseGeocodeLocation(cordinates,completionHandler: { [weak self] placemrk, _ in
            guard let self = self else {return}
            self.cityButton.setTitle(placemrk?.first?.locality, for: .normal)
        })
        viewModel?.saveLocation(location)
    }
}

extension MainViewController : SearchDelegate {
    func setLocation(city: CityModel) {
        self.cityButton.setTitle(city.name, for: .normal)
        viewModel?.saveLocation(CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon))
    }
}
