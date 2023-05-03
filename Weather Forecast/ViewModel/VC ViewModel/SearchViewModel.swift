//
//  SearchViewModel.swift
//  Weather Forecast
//
//  Created by 4steps on 03.05.23.
//

import Foundation


class SearchViewModel: NSObject {
    
    //MARK: - vars/lets
    var reloadTablView: (()->())?
    var filteredCities = [CityModel]() {
        didSet {
            self.reloadTablView?()
        }
    }
    private var lat: Double?
    private var lon: Double?
    
    var numberOfCell: Int {
        if filteredCities.count > 20 {
            return 20
        } else if filteredCities.count > 0 {
            return filteredCities.count
        } else {
            return 1
        }
    }
    
    //MARK: - flow func
    
    
    func searchCity(text: String) {
        guard let cities = CityDataSource.shared.cities else { return }
        
        filteredCities = cities.filter({ (city: CityModel) in
            if text.count > 2 && city.name.lowercased().contains(text.lowercased()) {
                return true
            }
            return false
        })
        filteredCities.sort(by: {$0.name.count < $1.name.count})
    }
    
    
    func filteredCityIsEmpty() -> Bool {
        filteredCities.isEmpty
    }
}

struct SearchCellViewModel {
    var city: String
    var country: String
}
